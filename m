From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Wed, 26 Jul 2017 16:07:44 +0100
Subject: [cip-dev] change to the
	git://git.linaro.org/qa/test-definitions.git repos breaks the
	BBB health check
In-Reply-To: <87o9s7jxev.fsf@ctlt579.codethink.co.uk> (Robert Marshall's
	message of "Wed, 26 Jul 2017 11:38:16 +0100")
References: <87o9s7jxev.fsf@ctlt579.codethink.co.uk>
Message-ID: <87k22vjkxr.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall <robert.marshall@codethink.co.uk> writes:

> Hi,
>
> A change yesterday to the git://git.linaro.org/qa/test-definitions.git
> repos, removing obsolete directories, has removed the ubuntu one that the
> b at d BBB health check used so that the default beaglebone health check will
> now fail. We're working on a fix!
>

The repos versions of the beaglebone black tests have been updated with
a valid test. If you have an already provisioned box you will need to
manually change the tests/bbb* files with this diff:


      from: git
-     path: ubuntu/smoke-tests-basic.yaml
+     path: common/dt-selftests.yaml
      name: smoke-tests


Robert
