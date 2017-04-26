From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 26 Apr 2017 17:27:08 +0900
Subject: [cip-dev] Problems installing "Board at desk"
Message-ID: <009901d2be66$e4d28830$ae779890$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

I am trying the "board-at-desk-single-dev" project (sorry to do it so late).
I managed to build the CIP kernel and see the job results using KernelCI.
However, I am having problems with LAVA health checks (see at the end).

First, I would like to report on a few problems I had to solve to get the kernel built:

*************************************************
1) Although now I know that the current development occurs at
https://gitlab.com/cip-project/board-at-desk-single-dev.git
googling "CIP kernelci" gives also the following outdated (?) sites which can 
be confusing:
https://github.com/cip-project/cip-kernelci.git
https://gitlab.com/cip-project/kernelci-debian.git

Q: are they necessary? or is it some misunderstanding from my side?

2) Problems behind a proxy

a) I did the following to setup proxy settings for vagrant on Ubuntu 16.04 Xenial:

   $ sudo apt-get remove vagrant <-- gives errors when installing vagrant-proxyconf
   $ dpkg -i vagrant_1.9.4_x86_64.deb
   $ vagrant plugin install vagrant-proxyconf
   $ vi Vagrantfile
+ if Vagrant.has_plugin?("vagrant-proxyconf")
+   config.proxy.http     = "http://xxx:yyyy/"
+   config.proxy.https    = "https://xxx:yyy/"
+   config.proxy.no_proxy = "127.0.0.1,localhost,xxxx."
+ end

Q: maybe it would be good to add this to the tutorial

b) I got an error during vagrant up

==> default: fatal: [kernel-ci-backend]: FAILED! => {"changed": false, "cmd": "/usr/bin/apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv EA312927", "failed": true, 
- Solved it by adding port 80 for apt-key
   $ vagrant ssh
    guest$ vi kernelci-backend/roles/install-deps/tasks/install-mongodb.yml
                - hkp://keyserver.ubuntu.com
	+hkp://keyserver.ubuntu.com:80
     [Alt]  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

Q: if that works without proxies, maybe it should be set to 80 by default?

c) I got a lot of warnings like these ones

- Warning 1 (ignore)
    GetPassWarning: Can not control echo on the terminal.? or ?Warning: Password input may be echoed.? - These do not affect the operation of the KernelCI VM.
- Warning 2 (ignore)
    ==> default: lava_scheduler_app.Notification.job_status_trigger: (fields.W901) CommaSeparatedIntegerField has been deprecated. Support for it (except in historical migrations) will be removed in Django 2.0.
    ==> default: 	HINT: Use CharField(validators=[validate_comma_separated_integer_list]) instead.

Q: The tutorial mentions Warning 1, but not Warning 2. Maybe adding that would be a good idea. 

3) Modifying the 8080 port (very commonly used port, e.g. Fuego ;_+)

I solved this by
   $   vi Vagrantfile
       +  config.vm.network :forwarded_port, guest: 8081, host: 8081
    $ sudo vi /etc/apache2/ports.conf
        -> change to 8081
    $ sudo vi /etc/apache2/sites-enabled/lava-server.conf
        -> change to 8081
    $ sudo service apache2 restart
    $ sudo /etc/init.d/lava-server restart

Q: maybe this could be automated (?)
*************************************************

Second, regarding to LAVA health checks I think this is again a problem with being behind a
proxy but I'm not sure how to debug it. These are the error messages that I get
with QEMU's health check (/vagrant/tests/qemu-health-check.yaml)

    - log:
        Root tmp directory created at /var/lib/lava/dispatcher/tmp/7
        start: 0 validate
        Validating that https://images.validation.linaro.org/kvm/standard/stretch-2.img.gz exists
        no device environment specified
        Invalid job definition
        Invalid job data: ["HTTPSConnectionPool(host='images.validation.linaro.org', port=443): Max retries exceeded with url: /kvm/standard/stretch-2.img.gz (Caused by NewConnectionError('<requests.packages.urllib3.connection.VerifiedHTTPSConnection object@0x7f430c9b9c50>: Failed to establish a new connection: [Errno -5] No address associated with hostname',))"]
        validate duration: 0.02
        Cleanup: removing /var/lib/lava/dispatcher/tmp/7
    - traceback
        Traceback (most recent call last):
          File "/usr/lib/python2.7/dist-packages/lava/dispatcher/commands.py", line 88, in run_pipeline_job
            job.validate(simulate=validate_only)
          File "/usr/lib/python2.7/dist-packages/lava_dispatcher/pipeline/job.py", line 173, in validate
            self.pipeline.validate_actions()
          File "/usr/lib/python2.7/dist-packages/lava_dispatcher/pipeline/action.py", line 205, in validate_actions
            raise JobError("Invalid job data: %s\n" % self.errors)
        JobError: Invalid job data: ["HTTPSConnectionPool(host='images.validation.linaro.org', port=443): Max retries exceeded with url: /kvm/standard/stretch-2.img.gz (Caused by NewConnectionError('<requests.packages.urllib3.connection.VerifiedHTTPSConnection object@0x7f430c9b9c50>: Failed to establish a new connection: [Errno -5] No address associated with hostname',))"]

If someone has a clue about this please let me know. 
# http_proxy-like variables are all defined in the VM (/etc/environment), and I can use wget and download
stretch-2.img.gz without problems.

Best regards,
Daniel
