From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Wed, 22 Aug 2018 14:55:42 +0100
Subject: [cip-dev] provisioning B@D with internet proxies
Message-ID: <871saqv735.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Following some liaison with Patryk Mungai of Renesas (thanks!) to try to get
B at D provisioned with their internet proxy settings - at the moment there
is nothing in the known issues on this - just the outstanding issue

https://gitlab.com/cip-project/cip-testing/testing/issues/99

a new issue was opened

https://gitlab.com/cip-project/cip-testing/testing/issues/195

the following is the outline of the necessary steps to create a B at D
instance with their proxy settings

- Add Sophos ssl certificates to the host
- Add the proxy settings to the Vagrant file as in #99
- Change the ansible install line in install_dependencies.sh to
     sudo -H DEBIAN_FRONTEND=noninteractive pip install --default-timeout=100 ansible
- create vagrant box which will fail in install_dependencies.sh with a no
    matching distribution found for cffi error
- In the vagrant box create a pip.conf file containing
  [global]
  default-timeout = 60
  trusted-host = pypi.org
	         pypi.python.org
	         files.pythonhosted.org
  (in .pip/pip.conf or a file matching the following -)
  export PIP_CONFIG_FILE=~/.pip/pip.conf
  - In the VM, using visudo add the following
      Defaults	env+=PIP_CONFIG_FILE
  - Copy the SSL certificates (in step 1) to the VM using vagrant scp to
     /usr/local/share/ca-certificates/extra
  - Run vagrant provision again
  - Then halt; run; provision as in step 6 of
     https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdeskdingledevdeployment#b-d-deployment-method-2-building-vm-from-scratch-using-vagrant-15


Some of this - the pip config will be investigated as to whether it can
be added to the generic install - the known issues will be updated once
that has been done to add a new point on configuration with an internet proxy.



Robert
-- 
Robert Marshall, Software Developer                       Codethink Ltd
Telephone: +44 7762 840 414       3rd Floor, Dale House, 35 Dale Street
https://www.codethink.co.uk/         MANCHESTER, M1 2HF. United Kingdom
