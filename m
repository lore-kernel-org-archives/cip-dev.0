From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 15 Mar 2019 14:07:11 +0900
Subject: [cip-dev] add a few tools to Deby CIP core for testing
Message-ID: <1552626432-7359-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

I have added a few packages to the meta-common layer for testing.

[PATCH] common: add alsa-utils util-linux libpng for testing

When the build is finished I will update the filesystem on S3.

Unfortunately, there are no recipes for bonnie++ and imagemagick in Deby.

Thanks,
Daniel
