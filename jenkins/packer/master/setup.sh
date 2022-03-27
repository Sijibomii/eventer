#!/bin/bash

echo "Installing Amazon Linux extras"
amazon-linux-extras install epel -y

echo "Install Jenkins stable release"
yum clean all
yum remove -y java
yum install -y java-1.8.0-openjdk
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install -y jenkins
chkconfig jenkins on

echo "Install git"
yum install -y git

echo "install github cli"
curl https://raw.githubusercontent.com/dvershinin/apt-get-centos/master/apt-get.sh -o /usr/local/bin/apt-get
chmod 0755 /usr/local/bin/apt-get
apt update
apt install gh

echo "Install Docker engine"
yum update -y
yum install docker -y
usermod -aG docker ec2-user
usermod -aG docker jenkins
chmod 666 /var/run/docker.sock
systemctl enable docker

echo "Setup SSH key"
mkdir /var/lib/jenkins/.ssh
touch /var/lib/jenkins/.ssh/known_hosts
chown -R jenkins:jenkins /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
mv /tmp/id_rsa /var/lib/jenkins/.ssh/id_rsa
chmod 600 /var/lib/jenkins/.ssh/id_rsa
chown -R jenkins:jenkins /var/lib/jenkins/.ssh/id_rsa

echo "Configure Jenkins"
mkdir -p /var/lib/jenkins/init.groovy.d
mv /tmp/scripts/*.groovy /var/lib/jenkins/init.groovy.d/
chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d
mv /tmp/config/jenkins /etc/sysconfig/jenkins
chmod +x /tmp/config/install-plugins.sh
set -e

plugin_dir=/var/lib/jenkins/plugins
file_owner=jenkins.jenkins

mkdir -p /var/lib/jenkins/plugins
curl -L --silent --output ${plugin_dir}/trilead-api.hpi  https://updates.jenkins-ci.org/latest/trilead-api.hpi
curl -L --silent --output ${plugin_dir}/token-macro.hpi  https://updates.jenkins-ci.org/latest/token-macro.hpi
curl -L --silent --output ${plugin_dir}/variant.hpi  https://updates.jenkins-ci.org/latest/variant.hpi
curl -L --silent --output ${plugin_dir}/windows-slaves.hpi  https://updates.jenkins-ci.org/latest/windows-slaves.hpi
curl -L --silent --output ${plugin_dir}/workflow-aggregator.hpi  https://updates.jenkins-ci.org/latest/workflow-aggregator.hpi
curl -L --silent --output ${plugin_dir}/workflow-basic-steps.hpi  https://updates.jenkins-ci.org/latest/workflow-basic-steps.hpi
curl -L --silent --output ${plugin_dir}/workflow-api.hpi  https://updates.jenkins-ci.org/latest/workflow-api.hpi
curl -L --silent --output ${plugin_dir}/workflow-cps.hpi  https://updates.jenkins-ci.org/latest/workflow-cps.hpi
curl -L --silent --output ${plugin_dir}/workflow-cps-global-lib.hpi  https://updates.jenkins-ci.org/latest/workflow-cps-global-lib.hpi
curl -L --silent --output ${plugin_dir}/workflow-durable-task-step.hpi  https://updates.jenkins-ci.org/latest/workflow-durable-task-step.hpi
curl -L --silent --output ${plugin_dir}/workflow-job.hpi  https://updates.jenkins-ci.org/latest/workflow-job.hpi
curl -L --silent --output ${plugin_dir}/workflow-multibranch.hpi  https://updates.jenkins-ci.org/latest/workflow-multibranch.hpi
curl -L --silent --output ${plugin_dir}/workflow-scm-step.hpi  https://updates.jenkins-ci.org/latest/workflow-scm-step.hpi
curl -L --silent --output ${plugin_dir}/workflow-step-api.hpi  https://updates.jenkins-ci.org/latest/workflow-step-api.hpi
curl -L --silent --output ${plugin_dir}/workflow-support.hpi  https://updates.jenkins-ci.org/latest/workflow-support.hpi
curl -L --silent --output ${plugin_dir}/ace-editor.hpi  https://updates.jenkins-ci.org/latest/ace-editor.hpi
curl -L --silent --output ${plugin_dir}/amazon-ecr.hpi  https://updates.jenkins-ci.org/latest/amazon-ecr.hpi
curl -L --silent --output ${plugin_dir}/antisamy-markup-formatter.hpi  https://updates.jenkins-ci.org/latest/antisamy-markup-formatter.hpi
curl -L --silent --output ${plugin_dir}/ant.hpi  https://updates.jenkins-ci.org/latest/ant.hpi
curl -L --silent --output ${plugin_dir}/apache-httpcomponents-client-4-api.hpi  https://updates.jenkins-ci.org/latest/apache-httpcomponents-client-4-api.hpi
curl -L --silent --output ${plugin_dir}/authentication-tokens.hpi  https://updates.jenkins-ci.org/latest/authentication-tokens.hpi
curl -L --silent --output ${plugin_dir}/aws-credentials.hpi  https://updates.jenkins-ci.org/latest/aws-credentials.hpi
curl -L --silent --output ${plugin_dir}/aws-java-sdk.hpi  https://updates.jenkins-ci.org/latest/aws-java-sdk.hpi
curl -L --silent --output ${plugin_dir}/caffeine-api.hpi  https://updates.jenkins-ci.org/latest/caffeine-api.hpi
curl -L --silent --output ${plugin_dir}/blueocean-core-js.hpi  https://updates.jenkins-ci.org/latest/blueocean-core-js.hpi
curl -L --silent --output ${plugin_dir}/structs.hpi  https://updates.jenkins-ci.org/latest/structs.hpi
curl -L --silent --output ${plugin_dir}/checks-api.hpi  https://updates.jenkins-ci.org/latest/checks-api.hpi
curl -L --silent --output ${plugin_dir}/plugin-util-api.hpi  https://updates.jenkins-ci.org/latest/plugin-util-api.hpi
curl -L --silent --output ${plugin_dir}/bootstrap4-api.hpi  https://updates.jenkins-ci.org/latest/bootstrap4-api.hpi
curl -L --silent --output ${plugin_dir}/echarts-api.hpi  https://updates.jenkins-ci.org/latest/echarts-api.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi
curl -L --silent --output ${plugin_dir}/ssh.hpi  https://updates.jenkins-ci.org/latest/ssh.hpi
curl -L --silent --output ${plugin_dir}/ssh-agent.hpi  https://updates.jenkins-ci.org/latest/ssh-agent.hpi
curl -L --silent --output ${plugin_dir}/ssh-credentials.hpi  https://updates.jenkins-ci.org/latest/ssh-credentials.hpi
curl -L --silent --output ${plugin_dir}/pipeline-build-step.hpi  https://updates.jenkins-ci.org/latest/pipeline-build-step.hpi
curl -L --silent --output ${plugin_dir}/pipeline-graph-analysis.hpi  https://updates.jenkins-ci.org/latest/pipeline-graph-analysis.hpi
curl -L --silent --output ${plugin_dir}/pipeline-input-step.hpi  https://updates.jenkins-ci.org/latest/pipeline-input-step.hpi
curl -L --silent --output ${plugin_dir}/pipeline-milestone-step.hpi  https://updates.jenkins-ci.org/latest/pipeline-milestone-step.hpi
curl -L --silent --output ${plugin_dir}/pipeline-model-api.hpi  https://updates.jenkins-ci.org/latest/pipeline-model-api.hpi
curl -L --silent --output ${plugin_dir}/pipeline-model-declarative-agent.hpi  https://updates.jenkins-ci.org/latest/pipeline-model-declarative-agent.hpi
curl -L --silent --output ${plugin_dir}/pipeline-model-definition.hpi  https://updates.jenkins-ci.org/latest/pipeline-model-definition.hpi
curl -L --silent --output ${plugin_dir}/pipeline-model-extensions.hpi  https://updates.jenkins-ci.org/latest/pipeline-model-extensions.hpi
curl -L --silent --output ${plugin_dir}/pipeline-multibranch-defaults.hpi  https://updates.jenkins-ci.org/latest/pipeline-multibranch-defaults.hpi
curl -L --silent --output ${plugin_dir}/pipeline-rest-api.hpi  https://updates.jenkins-ci.org/latest/pipeline-rest-api.hpi
curl -L --silent --output ${plugin_dir}/pipeline-stage-step.hpi  https://updates.jenkins-ci.org/latest/pipeline-stage-step.hpi
curl -L --silent --output ${plugin_dir}/pipeline-stage-tags-metadata.hpi  https://updates.jenkins-ci.org/latest/pipeline-stage-tags-metadata.hpi
curl -L --silent --output ${plugin_dir}/pipeline-stage-view.hpi  https://updates.jenkins-ci.org/latest/pipeline-stage-view.hpi
curl -L --silent --output ${plugin_dir}/plain-credentials.hpi  https://updates.jenkins-ci.org/latest/plain-credentials.hpi
curl -L --silent --output ${plugin_dir}/pubsub-light.hpi  https://updates.jenkins-ci.org/latest/pubsub-light.hpi
curl -L --silent --output ${plugin_dir}/run-condition.hpi  https://updates.jenkins-ci.org/latest/run-condition.hpi
curl -L --silent --output ${plugin_dir}/scm-api.hpi  https://updates.jenkins-ci.org/latest/scm-api.hpi
curl -L --silent --output ${plugin_dir}/script-security.hpi  https://updates.jenkins-ci.org/latest/script-security.hpi
curl -L --silent --output ${plugin_dir}/slack.hpi  https://updates.jenkins-ci.org/latest/slack.hpi
curl -L --silent --output ${plugin_dir}/see-gateway.hpi  https://updates.jenkins-ci.org/latest/see-gateway.hpi
curl -L --silent --output ${plugin_dir}/git.hpi  https://updates.jenkins-ci.org/latest/git.hpi
curl -L --silent --output ${plugin_dir}/git-client.hpi  https://updates.jenkins-ci.org/latest/git-client.hpi
curl -L --silent --output ${plugin_dir}/git-server.hpi  https://updates.jenkins-ci.org/latest/git-server.hpi
curl -L --silent --output ${plugin_dir}/github.hpi  https://updates.jenkins-ci.org/latest/github.hpi
curl -L --silent --output ${plugin_dir}/github-api.hpi  https://updates.jenkins-ci.org/latest/github-api.hpi
curl -L --silent --output ${plugin_dir}/github-branch-source.hpi  https://updates.jenkins-ci.org/latest/github-branch-source.hpi
curl -L --silent --output ${plugin_dir}/github-pullrequest.hpi  https://updates.jenkins-ci.org/latest/github-pullrequest.hpi
curl -L --silent --output ${plugin_dir}/handlebards.hpi  https://updates.jenkins-ci.org/latest/handlebards.hpi
curl -L --silent --output ${plugin_dir}/handy-uri-templates-2-api.hpi  https://updates.jenkins-ci.org/latest/handy-uri-templates-2-api.hpi
curl -L --silent --output ${plugin_dir}/htmlpublisher.hpi  https://updates.jenkins-ci.org/latest/htmlpublisher.hpi
curl -L --silent --output ${plugin_dir}/jackson2-api.hpi  https://updates.jenkins-ci.org/latest/jackson2-api.hpi
curl -L --silent --output ${plugin_dir}/javadoc.hpi  https://updates.jenkins-ci.org/latest/javadoc.hpi
curl -L --silent --output ${plugin_dir}/jdk-tool.hpi  https://updates.jenkins-ci.org/latest/jdk-tool.hpi
curl -L --silent --output ${plugin_dir}/jenkins-design-language.hpi  https://updates.jenkins-ci.org/latest/jenkins-design-language.hpi
curl -L --silent --output ${plugin_dir}/jira.hpi  https://updates.jenkins-ci.org/latest/jira.hpi
curl -L --silent --output ${plugin_dir}/jquery.hpi  https://updates.jenkins-ci.org/latest/jquery.hpi
curl -L --silent --output ${plugin_dir}/jquery-detached.hpi  https://updates.jenkins-ci.org/latest/jquery-detached.hpi
curl -L --silent --output ${plugin_dir}/jsch.hpi  https://updates.jenkins-ci.org/latest/jsch.hpi
curl -L --silent --output ${plugin_dir}/junit.hpi  https://updates.jenkins-ci.org/latest/junit.hpi
curl -L --silent --output ${plugin_dir}/ldap.hpi  https://updates.jenkins-ci.org/latest/ldap.hpi
curl -L --silent --output ${plugin_dir}/mailer.hpi  https://updates.jenkins-ci.org/latest/mailer.hpi
curl -L --silent --output ${plugin_dir}/matrix-auth.hpi  https://updates.jenkins-ci.org/latest/matrix-auth.hpi
curl -L --silent --output ${plugin_dir}/matrix-project.hpi  https://updates.jenkins-ci.org/latest/matrix-project.hpi
curl -L --silent --output ${plugin_dir}/maven-plugin.hpi  https://updates.jenkins-ci.org/latest/maven-plugin.hpi
curl -L --silent --output ${plugin_dir}/mercurial.hpi  https://updates.jenkins-ci.org/latest/mercurial.hpi
curl -L --silent --output ${plugin_dir}/momentjs.hpi  https://updates.jenkins-ci.org/latest/momentjs.hpi
curl -L --silent --output ${plugin_dir}/pam-auth.hpi  https://updates.jenkins-ci.org/latest/pam-auth.hpi
curl -L --silent --output ${plugin_dir}/parameterized-trigger.hpi  https://updates.jenkins-ci.org/latest/parameterized-trigger.hpi
curl -L --silent --output ${plugin_dir}/blueocean.hpi  https://updates.jenkins-ci.org/latest/blueocean.hpi
curl -L --silent --output ${plugin_dir}/blueocean-autofavorite.hpi  https://updates.jenkins-ci.org/latest/blueocean-autofavorite.hpi
curl -L --silent --output ${plugin_dir}/blueocean-bitbucket-pipeline.hpi  https://updates.jenkins-ci.org/latest/blueocean-bitbucket-pipeline.hpi
curl -L --silent --output ${plugin_dir}/blueocean-commons.hpi  https://updates.jenkins-ci.org/latest/blueocean-commons.hpi
curl -L --silent --output ${plugin_dir}/blueocean-configs.hpi  https://updates.jenkins-ci.org/latest/blueocean-configs.hpi
curl -L --silent --output ${plugin_dir}/blueocean-config-js.hpi  https://updates.jenkins-ci.org/latest/blueocean-config-js.hpi
curl -L --silent --output ${plugin_dir}/blueocean-dashboard.hpi  https://updates.jenkins-ci.org/latest/blueocean-dashboard.hpi
curl -L --silent --output ${plugin_dir}/blueocean-display-url.hpi  https://updates.jenkins-ci.org/latest/blueocean-display-url.hpi
curl -L --silent --output ${plugin_dir}/blueocean-events.hpi  https://updates.jenkins-ci.org/latest/blueocean-events.hpi
curl -L --silent --output ${plugin_dir}/blueocean-git-pipeline.hpi  https://updates.jenkins-ci.org/latest/blueocean-git-pipeline.hpi
curl -L --silent --output ${plugin_dir}/blueocean-github-pipeline.hpi  https://updates.jenkins-ci.org/latest/blueocean-github-pipeline.hpi
curl -L --silent --output ${plugin_dir}/blueocean-i18n.hpi  https://updates.jenkins-ci.org/latest/blueocean-i18n.hpi
curl -L --silent --output ${plugin_dir}/blueocean-jira.hpi  https://updates.jenkins-ci.org/latest/blueocean-jira.hpi
curl -L --silent --output ${plugin_dir}/blueocean-jwt.hpi  https://updates.jenkins-ci.org/latest/blueocean-jwt.hpi
curl -L --silent --output ${plugin_dir}/blueocean-personalization.hpi  https://updates.jenkins-ci.org/latest/blueocean-personalization.hpi
curl -L --silent --output ${plugin_dir}/blueocean-pipeline-api-impl.hpi  https://updates.jenkins-ci.org/latest/blueocean-pipeline-api-impl.hpi
curl -L --silent --output ${plugin_dir}/blueocean-pipeline-editor.hpi  https://updates.jenkins-ci.org/latest/blueocean-pipeline-editor.hpi
curl -L --silent --output ${plugin_dir}/blueocean-pipeline-scm-api.hpi  https://updates.jenkins-ci.org/latest/blueocean-pipeline-scm-api.hpi
curl -L --silent --output ${plugin_dir}/blueocean-rest.hpi  https://updates.jenkins-ci.org/latest/blueocean-rest.hpi
curl -L --silent --output ${plugin_dir}/blueocean-rest-impl.hpi  https://updates.jenkins-ci.org/latest/blueocean-rest-impl.hpi
curl -L --silent --output ${plugin_dir}/blueocean-web.hpi  https://updates.jenkins-ci.org/latest/blueocean-web.hpi
curl -L --silent --output ${plugin_dir}/bouncycastle-api.hpi  https://updates.jenkins-ci.org/latest/bouncycastle-api.hpi
curl -L --silent --output ${plugin_dir}/branch-api.hpi  https://updates.jenkins-ci.org/latest/branch-api.hpi
curl -L --silent --output ${plugin_dir}/build-pipeline-plugin.hpi  https://updates.jenkins-ci.org/latest/build-pipeline-plugin.hpi
curl -L --silent --output ${plugin_dir}/cloudbees-bitbucket-branch-source.hpi  https://updates.jenkins-ci.org/latest/cloudbees-bitbucket-branch-source.hpi
curl -L --silent --output ${plugin_dir}/cloudbees-folder.hpi  https://updates.jenkins-ci.org/latest/cloudbees-folder.hpi
curl -L --silent --output ${plugin_dir}/command-launcher.hpi  https://updates.jenkins-ci.org/latest/command-launcher.hpi
curl -L --silent --output ${plugin_dir}/conditional-buildstep.hpi  https://updates.jenkins-ci.org/latest/conditional-buildstep.hpi
curl -L --silent --output ${plugin_dir}/config-file-provider.hpi  https://updates.jenkins-ci.org/latest/config-file-provider.hpi
curl -L --silent --output ${plugin_dir}/credentials.hpi  https://updates.jenkins-ci.org/latest/credentials.hpi
curl -L --silent --output ${plugin_dir}/credentials-binding.hpi  https://updates.jenkins-ci.org/latest/credentials-binding.hpi
curl -L --silent --output ${plugin_dir}/display-url-api.hpi  https://updates.jenkins-ci.org/latest/display-url-api.hpi
curl -L --silent --output ${plugin_dir}/docker-commons.hpi  https://updates.jenkins-ci.org/latest/docker-commons.hpi
curl -L --silent --output ${plugin_dir}/docker-workflow.hpi  https://updates.jenkins-ci.org/latest/docker-workflow.hpi
curl -L --silent --output ${plugin_dir}/durable-task.hpi  https://updates.jenkins-ci.org/latest/durable-task.hpi
curl -L --silent --output ${plugin_dir}/email-ext.hpi  https://updates.jenkins-ci.org/latest/email-ext.hpi
curl -L --silent --output ${plugin_dir}/embeddable-build-status.hpi  https://updates.jenkins-ci.org/latest/embeddable-build-status.hpi
curl -L --silent --output ${plugin_dir}/external-monitor-job.hpi  https://updates.jenkins-ci.org/latest/external-monitor-job.hpi
curl -L --silent --output ${plugin_dir}/favorite.hpi  https://updates.jenkins-ci.org/latest/favorite.hpi

echo "fixing permissions"

chown ${file_owner} ${plugin_dir} -R

echo "all done"
systemctl start docker
service jenkins start
