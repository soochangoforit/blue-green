# 실제 jar 파일이 위치하는 곳으로 이동
cd /home/ec2-user/blue-green/build/libs

echo "> 복사좀 되어라 !!!" >> /home/ec2-user/deploy.log
# jar 파일을 가져온다.??
BUILD_JAR=$(ls *.jar)

# jar 파일 이름을 가져온다 (실행 중인 pid 가져오기 위해)
JAR_NAME=$(basename $BUILD_JAR)
echo "> build 파일명: $JAR_NAME" >> /home/ec2-user/deploy.log


# 원래 프로젝트 위치에 있던 jar 파일을 최상단 위치에 복사하는 과정으로 보인다.
echo "> build 파일 복사" >> /home/ec2-user/deploy.log
DEPLOY_PATH=/home/ec2-user/
cp $BUILD_JAR $DEPLOY_PATH


# 현재 실행중인 애플리케이션 pid 확인
echo "> 현재 실행중인 애플리케이션 pid 확인" >> /home/ec2-user/deploy.log
CURRENT_PID=$(pgrep -f $JAR_NAME)


if [ -z $CURRENT_PID ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다." >> /home/ec2-user/deploy.log
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

# jar 파일은 최상단에 한번 더 복사가 되었다.
DEPLOY_JAR=$DEPLOY_PATH$JAR_NAME
echo "> DEPLOY_JAR 배포"    >> /home/ec2-user/deploy.log
nohup java -jar $DEPLOY_JAR >> /home/ec2-user/deploy.log 2>/home/ec2-user/deploy_err.log &




