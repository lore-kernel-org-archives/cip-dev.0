From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 19 Jul 2019 22:48:13 +0000
Subject: [cip-dev] FW: [Linaro/test-definitions] Preempt rt v1 review (#85)
In-Reply-To: <Linaro/test-definitions/pull/85@github.com>
References: <Linaro/test-definitions/pull/85@github.com>
Message-ID: <TYAPR01MB2285C2A350DAF6B1EB72D0FCB7CB0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

This PR from Daniel is probably of interest to you.

Kind regards, Chris

From: Daniel Wagner <notifications@github.com>
Sent: 19 July 2019 23:51
To: Linaro/test-definitions <test-definitions@noreply.github.com>
Cc: Subscribed <subscribed@noreply.github.com>
Subject: [Linaro/test-definitions] Preempt rt v1 review (#85)


I am maintaining the v4.4-rt stable tree and using LAVA with the test-definition to verify my work.

With a Python script I create several tests jobs. All started very small but nowadays I a pretty happy with what I got. Still a lot to do but it's a good starting point

Anyway, I improved (obviously it's a point of view thing) the current test scripts in test-definition slightly:
?        introduce MAX_LATENCY: fail if the max latency is reached
?        added a bunch of command options (e,g. duration)
?        extended the error parsing for the test tools

The first point is important to my work. I really need the test to fail if on a given board the values go above MAX_LATENCY.

Hope this makes any sense.

________________________________
You can view, comment on, or merge this pull request online at:

  https://github.com/Linaro/test-definitions/pull/85

Commit Summary
?        cyclictest: Update parameters
?        signaltest: Update parameters
?        rt-migrate-test: Parse pass/fail result
?        cyclictest: Add MAX_LATENCY argument
?        signaltest: Add MAX_LATENCY argument
?        pi-stress: Check for errors in the log file
?        pmqtest: Add MAX_LATENCY argument
?        sh-test-lib: Add convert_to_sec helper
?        cyclictest: Introduce duration option
?        pi-stress: Introduce duration option
?        pmqtest: Introduce duration option
?        rt-migrate-test: Introduce duration option
?        signaltest: Introduce duration option
File Changes
?        M automated/lib/sh-test-lib<https://github.com/Linaro/test-definitions/pull/85/files#diff-0> (23)
?        M automated/linux/cyclictest/cyclictest.sh<https://github.com/Linaro/test-definitions/pull/85/files#diff-1> (26)
?        M automated/linux/cyclictest/cyclictest.yaml<https://github.com/Linaro/test-definitions/pull/85/files#diff-2> (15)
?        A automated/linux/cyclictest/parse_results.py<https://github.com/Linaro/test-definitions/pull/85/files#diff-3> (54)
?        M automated/linux/pi-stress/pi-stress.sh<https://github.com/Linaro/test-definitions/pull/85/files#diff-4> (22)
?        M automated/linux/pi-stress/pi-stress.yaml<https://github.com/Linaro/test-definitions/pull/85/files#diff-5> (6)
?        A automated/linux/pmqtest/parse_results.py<https://github.com/Linaro/test-definitions/pull/85/files#diff-6> (60)
?        M automated/linux/pmqtest/pmqtest.sh<https://github.com/Linaro/test-definitions/pull/85/files#diff-7> (16)
?        M automated/linux/pmqtest/pmqtest.yaml<https://github.com/Linaro/test-definitions/pull/85/files#diff-8> (7)
?        M automated/linux/rt-migrate-test/rt-migrate-test.sh<https://github.com/Linaro/test-definitions/pull/85/files#diff-9> (9)
?        M automated/linux/rt-migrate-test/rt-migrate-test.yaml<https://github.com/Linaro/test-definitions/pull/85/files#diff-10> (3)
?        A automated/linux/signaltest/parse_results.py<https://github.com/Linaro/test-definitions/pull/85/files#diff-11> (54)
?        M automated/linux/signaltest/signaltest.sh<https://github.com/Linaro/test-definitions/pull/85/files#diff-12> (20)
?        M automated/linux/signaltest/signaltest.yaml<https://github.com/Linaro/test-definitions/pull/85/files#diff-13> (10)
Patch Links:
?        https://github.com/Linaro/test-definitions/pull/85.patch
?        https://github.com/Linaro/test-definitions/pull/85.diff

?
You are receiving this because you are subscribed to this thread.
Reply to this email directly, view it on GitHub<https://github.com/Linaro/test-definitions/pull/85?email_source=notifications&email_token=AF2XINQYLFYRO6R6LM4HUTDQAHIETA5CNFSM4IFGXHUKYY3PNVWWK3TUL52HS4DFUVEXG43VMWVGG33NNVSW45C7NFSM4HAJG7FQ>, or mute the thread<https://github.com/notifications/unsubscribe-auth/AF2XINVQFERZUKEO4NEARNDQAHIETANCNFSM4IFGXHUA>.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190719/c9852a3f/attachment-0001.html>
