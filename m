Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5554DF557E3
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 08:33:53 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15195.1776672814082048416
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2026 01:13:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alperen.erdogan@siemens.com header.s=fm2 header.b=jjRzruqH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1334730-20260420080329f84c9d0c830002075d-rpyumd@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260420080329f84c9d0c830002075d
        for <cip-dev@lists.cip-project.org>;
        Mon, 20 Apr 2026 10:03:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alperen.erdogan@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UFhn8f3MSp20MaChk8HZ1qdmrkE1kiGglbdi74W+rTM=;
 b=jjRzruqHXIkFQRzh6ufbmpo+vApx1B4vtqbKneJ6Wje2JSuZGbAWm2e5rW5PCfuzClfUy8
 uokCiEGx3DBcnF1y8TJIBltVpHGnzR5NCGpq6C9cUeqtnU24NMqfSpstWRkwX3ufW+W/d7aM
 PAET5BX+CuCf1H59l7upVJ+qZ3+HZlnAoXCBohQuXVFEe/DSbaLz8dH/JdUvruTYHHIAnUoW
 PhDAKZrHXpU036LrtvfWRkBkLqgdFgXoeSioHpHtty/tm2ofu/McKzP38VVScFXCK97dpjdW
 +DwABw5k4bDX+lTxLAA2r0ecLvgVOTWnSpUDk7MVYav9VRiwdgdjyyHg==;
From: Alperen Erdogan <alperen.erdogan@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: erhan.cakir@siemens.com,
	gokhan.cetin@siemens.com,
	jan.kiszka@siemens.com,
	Alperen Erdogan <alperen.erdogan@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] doc: update wfx documentation for configurable device identity
Date: Mon, 20 Apr 2026 11:00:18 +0300
Message-ID: <20260420080018.7091-3-alperen.erdogan@siemens.com>
In-Reply-To: <20260420080018.7091-1-alperen.erdogan@siemens.com>
References: <20260420080018.7091-1-alperen.erdogan@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1334730:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2026 08:33:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22769

Update machine-id references to mention WFX_DEVICE_ID.

Signed-off-by: Alperen Erdogan <alperen.erdogan@siemens.com>
---
 doc/README.swupdate.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index f308d7e..affb85b 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -523,7 +523,7 @@ Now start the image which will contain the RT kernel:
 host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```

-Check the machine-id in `/etc/machine-id`. SWUpdate is launched with this `id` as the `client-id` and is later used to create `wfx` job for the client:
+By default, SWUpdate uses the machine-id from `/etc/machine-id` as the `client-id` (configurable via `WFX_DEVICE_ID` in the `swupdate-config-wfx` recipe). This `client-id` is later used to create `wfx` job for the client:
 ```
 root@demo cat /etc/machine-id
 049adc79659044f8887c83b3203c84f1
@@ -540,7 +540,7 @@ Create `wfx.workflow.dau.direct` wofkflow:
 host$ curl -L https://raw.githubusercontent.com/siemens/wfx/refs/heads/main/workflow/dau/wfx.workflow.dau.direct.yml | wfxctl workflow create -
 ```

-Create a wfx job that updates the device. Set `client-id` with the `id` from `/etc/machine-id` in qemu:
+Create a wfx job that updates the device. Set `client-id` with the device identity (default: `/etc/machine-id`) from qemu:
 ```
 host$ cat <<EOF | envsubst | wfxctl job create --client-id '049adc79659044f8887c83b3203c84f1' --workflow wfx.workflow.dau.direct -
 {
--
2.43.0


