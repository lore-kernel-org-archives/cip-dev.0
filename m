From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 29 Jan 2018 17:31:09 +0900
Subject: [cip-dev] [PATCH] Dockerfile: add iproute2
In-Reply-To: <1517214669-12918-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1517214669-12918-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1517214669-12918-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

runqemu requires /sbin/ip

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Dockerfile b/Dockerfile
index dbadb55..30fac76 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -15,7 +15,7 @@ RUN apt-get update && \
                        tar bzip2 curl dosfstools mtools parted \
                        syslinux tree python3-pip bc python3-yaml \
                        lsb-release python3-setuptools ssh-client \
-                       vim less mercurial && \
+                       vim less mercurial iproute2 && \
     echo 'deb http://deb.debian.org/debian stretch main' >> /etc/apt/sources.list.d/backports.list && \
     apt-get update && \
     apt-get install -y -f --no-install-recommends --target-release stretch \
-- 
2.7.4
