From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Wed, 26 Jul 2017 11:38:16 +0100
Subject: [cip-dev] change to the
	git://git.linaro.org/qa/test-definitions.git repos breaks the
	BBB health check
Message-ID: <87o9s7jxev.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

A change yesterday to the git://git.linaro.org/qa/test-definitions.git
repos, removing obsolete directories, has removed the ubuntu one that the
b at d BBB health check used so that the default beaglebone health check will
now fail. We're working on a fix!

Robert
