Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB668C2BD09
	for <webhook@archiver.kernel.org>; Wed,  3 Jul 2024 11:43:05 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.49036.1720006980181618222
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jul 2024 04:43:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=VSxLhWgg;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from localhost (dslb-002-207-026-217.002.207.pools.vodafone-ip.de [2.207.26.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 403B0882DB;
	Wed,  3 Jul 2024 13:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720006978;
	bh=gUUm/96DFbMllkeufs8yPtc8AwlanAbhXN2BPb+LczM=;
	h=From:To:Cc:Subject:Date:From;
	b=VSxLhWgg1AsdpfLyH/ixTkkccLBJIDjudZHoTYwIYRs882H3S2pkyRmgeJ82D3moc
	 xkNhJxJS+7zEW8zuJOZbSYW07pz2Hto+HHj+CClx0n+Q0T1T4MLRI8dN4dg+ak/Ufp
	 cUCaOUF/FP42ftOXtD1FUpAeFsyVPDZih8MuuIvpDcLTCQGxbbIyPljWXZ4lgHOVyO
	 YqVeu9ERG/aCf5BTH6OM6p+mhsVIWwMbclxZbfHWcwPdrZdnpw+GdtCJci/DROzABN
	 V4RDAvRYiVTD26Jauf1ZFGXc600Bzp5pGYGIX3F9Gd1E3lIzBaUf+DKalJSj+EgApf
	 zdlObhVvmMILQ==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH] swupdate.bbclass: make swu_files entries unique
Date: Wed,  3 Jul 2024 13:42:42 +0200
Message-ID: <20240703114242.1896508-1-ch@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jul 2024 11:43:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16367

In case a sw-description contains multiple entries of the same file,
swu_files will contains multiples of the same file and thus later
operations fail.

This change makes the files in the swu_files variable unique, so they
are only operated on once.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index e91238d..5e54853 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -205,7 +205,7 @@ IMAGE_CMD:swu() {
         swu_file_base=3D$(basename $swu_file)
         # Create symlinks for files used in the update image
         swu_files=3D$(awk '$1=3D=3D"filename"{gsub(/[",;]/, "", $3); pri=
nt $3}' \
-            "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}")
+            "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}" | sort |=
 uniq)
         export swu_files
         for file in $swu_files; do
             if [ -e "${WORKDIR}/$file" ]; then
--=20
2.39.2


