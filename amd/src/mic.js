// Standard license block omitted.
/*
 * @module     mod_digitala/mic
 * @copyright  2022 Name
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
import RecordRTC from 'RecordRTC';

let recorder;
let isRecording = false;
let audio;

const startStopRecording = (pagenum) => {
    switch (isRecording) {
        case false:
            navigator.mediaDevices.getUserMedia({audio: true})
                .then(stream => {
                    const options = {
                        audioBitsPerSecond: 16000,
                        type: 'audio',
                        recorderType: RecordRTC.StereoAudioRecorder,
                        mimeType: 'audio/wav'
                    };
                    recorder = new RecordRTC(stream, options);
                    isRecording = true;

                    recorder.startRecording();
                    window.console.log('started to record');

                    return;
                })
                .catch((err) => {
                    window.console.error(err);
                });
            break;

        case true:
            isRecording = false;
            recorder.stopRecording(() => {
                const audioBlob = recorder.getBlob();
                window.console.log('audioBlob:', audioBlob);

                const audioUrl = URL.createObjectURL(audioBlob);
                audio = new Audio(audioUrl);
                window.console.log('audioUrl', audioUrl);

                window.console.log('Enable submit button');
                document.getElementById('id_submitbutton').style.display = '';

                if (pagenum === 1) {
                    const form = new FormData();
                    form.append('repo_id', '');
                    form.append('ctx_id', '');
                    form.append('itemid', '');
                    form.append('savepath', '/');
                    form.append('sesskey', M.cfg.sesskey);
                    form.append('repo_upload_file', audioBlob, 'tottoroo.wav');
                    form.append('overwrite', '1');
                }
            });
            window.console.log(M.cfg);
            window.console.log('recording stopped');
            break;
    }
};

const listenRecording = () => {
    if (audio !== undefined) {
        audio.play();
    }
};

export const initializeMicrophone = (pagenum) => {
    const recButton = document.getElementById('record');
    const stopButton = document.getElementById('stopRecord');
    const listenButton = document.getElementById('listenButton');
    stopButton.disabled = true;
    listenButton.disabled = true;

    window.console.log('page number', pagenum);

    recButton.onclick = () => {
        recButton.style.backgroundColor = "blue";
        recButton.disabled = true;
        stopButton.disabled = false;
        listenButton.style.display = 'none';
        startStopRecording(pagenum);
    };
    stopButton.onclick = () => {
        recButton.style.backgroundColor = "red";
        recButton.disabled = false;
        stopButton.disabled = true;
        listenButton.disabled = false;
        listenButton.style.display = 'inline-block';
        startStopRecording(pagenum);
    };
    listenButton.onclick = () => {
        listenRecording();
    };
};