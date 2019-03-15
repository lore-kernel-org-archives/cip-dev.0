From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 15 Mar 2019 14:07:12 +0900
Subject: [cip-dev] [PATCH] common: add alsa-utils util-linux libpng for
	testing
In-Reply-To: <1552626432-7359-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1552626432-7359-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1552626432-7359-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Patryk mentioned that they were using these packages for internal testing.

Note: bonnie++ and imagemagick were also on the list but they are not supported by Deby at the moment.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 .../recipes-core/packagegroups/packagegroup-core-boot.bbappend         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/poky/meta-cip-common/recipes-core/packagegroups/packagegroup-core-boot.bbappend b/poky/meta-cip-common/recipes-core/packagegroups/packagegroup-core-boot.bbappend
index 4669429..d3637c3 100644
--- a/poky/meta-cip-common/recipes-core/packagegroups/packagegroup-core-boot.bbappend
+++ b/poky/meta-cip-common/recipes-core/packagegroups/packagegroup-core-boot.bbappend
@@ -56,4 +56,7 @@ PKG_DEBUG = "\
 	traceroute \
 	iputils-ping \
 	usbutils \
+	alsa-utils \
+	util-linux \
+	libpng \
 "
-- 
2.7.4
