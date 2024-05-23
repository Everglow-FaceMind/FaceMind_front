# facemind 요청사항입니다!

카메라를 통해 얻은 얼굴 이미지를 통해 심박수 측정 하는 앱입니다. (python 코드로 진행한 과정은 30fps)

시도하던 기능은 camera_stream을 통해서 이미지 (최대 30fps : 중요하지 않습니다.) 처리 과정을 거친 뒤 리스트에 저장하는 과정입니다.
image_utils , isolateUtils 파일이 사용되며  

image_utils 파일은 각각의 이미지를 처리하는 기능. isolateUtils는 이후 150 프레임 이상이 쌓였을 때 심박수를 측정하기 위한 코드를 작성하기 위해 만들어 놓았습니다.

흐름(파일)은 아래와 같습니다
scan Controller-> camera_screen -> camera_view (심박수 측정 관련 기능을 가진 파일 : image_utils, isolateUtils) 

현재 막힌 부분은 image를 rgb로 바꾸는 과정입니다. 이 과정이 진행되면 아래과정을 진행합니다.

1. mediapipe package를 활용해서 얼굴부분 face mech를 적용하고 박스를 지정합니다. 그리고 64*64 사이즈에 맞춰 자릅니다.
2. openCV_4 package를 활용해서 rgb -> green 색상으로 변경합니다
3. 앞의 frame을 리스트에 저장합니다.
4. 151개의 데이터가 쌓이면 이미지를 tensorflow lightning을 통해 tensor로 변환 rPPG signal을 추출합니다.
5. scidart package를 활용해서 peak를 찾습니다.
6. 연산을 통해 심박수, 스트레스 지수를 계산합니다.

위 내용과 관련해서 조언을 구하며 감사하다는 말씀 전해드립니다.