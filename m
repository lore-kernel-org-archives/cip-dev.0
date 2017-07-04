From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Tue, 4 Jul 2017 14:18:43 +0200
Subject: [cip-dev] Fwd: [Lava-users] OE/Yocto testcase
In-Reply-To: <798686ec-e4c1-91f2-ed5d-99feee607cd8@gmail.com>
References: <798686ec-e4c1-91f2-ed5d-99feee607cd8@gmail.com>
Message-ID: <595B87A3.4010207@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear CIP friends,

please check below. This is a use case we will meet in a few 
weeks/months. It is important to see others walking the same route.


-------- Forwarded Message --------
Subject: [Lava-users] OE/Yocto testcase
Date: Mon, 3 Jul 2017 20:19:31 +0300
From: Robert Berger <lava.users.mailinglist@gmail.com>
To: Lava-users at lists.linaro.org

Hi,

I succeeded in running the example Lava tests[1][2] on a Beagle Bone
Black in my lab.

Now I would like to test a core-image-minimal I built with Yocto and
cooked up something like this[3][4].

The result is unfortunately this[5].

I guess one of the problems I have is this:

lava-test: # ls -l /lava-38/
export SHELL=/bin/sh
/lava-38/bin/lava-test-runner /lava-38/0ls: cannot access '/lava-38/':
No such file or directory
lava-test: # export SHELL=/bin/sh
lava-test: # /lava-38/bin/lava-test-runner /lava-38/0
-sh: /lava-38/bin/lava-test-runner: No such file or directory

Regards,

Robert


[1]
https://validation.linaro.org/static/docs/v2/examples/test-jobs/standard-armmp-ramdisk-bbb.yaml
[2]
https://validation.linaro.org/static/docs/v2/examples/test-jobs/standard-armmp-nfs-bbb.yaml

[3]
https://github.com/RobertBerger/git.linaro.org-lava-team-refactoring/blob/master/bbb-core-image-minimal-1.yaml
[4]
https://github.com/RobertBerger/git.linaro.org-qa-test-definitions/blob/master/openembedded/smoke-tests-basic-core-image-minimal.yaml

[5] https://pastebin.com/14pjxhiN
_______________________________________________
Lava-users mailing list
Lava-users at lists.linaro.org
https://lists.linaro.org/mailman/listinfo/lava-users

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
