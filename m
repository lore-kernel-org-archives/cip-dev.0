Return-Path: <SRS0=8ysJ=DW=lists.cip-project.org=bounce+64572+5587+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BEEC433E7
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 20:30:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7888A2074D
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 20:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aajCu5kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7888A2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5587+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DbnlYY4521723x8YWqVs4KV1; Thu, 15 Oct 2020 13:30:48 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.491.1602793847303182397
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2020 13:30:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1EC3B1C0B7C; Thu, 15 Oct 2020 22:30:42 +0200 (CEST)
Date: Thu, 15 Oct 2020 22:30:41 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org, wens@csie.org
Subject: Re: [cip-dev] Bluetooth CVEs deciphered?
Message-ID: <20201015203041.GA15148@duo.ucw.cz>
References: <20201015180628.GB14732@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20201015180628.GB14732@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hEpMQFmg3gFImHc9WoQ12v2Kx4520388AA=
Content-Type: multipart/mixed; boundary="XxqADVjiB4TFpRYoHrAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602793848;
 bh=gcjRzZSX0caMoiSxH27/dO8aLMkreO5QoDxobhi4X6Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=aajCu5kj5vY6yLgNYxvUhF0d1fSgd+jF/eQ5TNAuzqVMt7lFL0KpFudqrNINOKzUal0
 AgS2KgQfO2AFeuYX7qkepBGDaqOBsnFU+VC6IW1OIXqi8ghWFIjLM+Aq1qOUL5n0micpY
 fYJUA/DdYXerKZ1T3zKYebYdHbK/B8zuZzQ=

--XxqADVjiB4TFpRYoHrAr
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I believe Google has good information which CVE corresponds to which
> patch, and I used that to improve cip-kernel-sec. Result is here. Can
> you take a look before I start fighting yml?

I believe I indentified the other 2 fixes, too. Here's updated diff.

Best regards,
								Pavel

diff --git a/issues/CVE-2020-12351.yml b/issues/CVE-2020-12351.yml
index 63f8b60..a28487e 100644
--- a/issues/CVE-2020-12351.yml
+++ b/issues/CVE-2020-12351.yml
@@ -1,37 +1,14 @@
-description: INTEL-SA-00435
+description: |
+  A heap-based type confusion affecting Linux kernel 4.8 and higher was di=
scovered in net/bluetooth/l2cap_core.c.
+advisory: |
 references:
-- https://www.intel.com/content/www/us/en/security-center/advisory/intel-s=
a-00435.html
-comments:
-  debian/carnil: |-
-    CVE-2020-12351, CVE-2020-12352 and CVE-2020-24490 are three
-    issues covered by a set of commits/patches sent upstream but
-    there is no clear association from the CVEs to the commits. So
-    duplicate this entry for now to all three CVEs.
-    The commits are:
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-1-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-2-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-3-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-4-luiz.=
dentz@gmail.com/
-    which are not yet in mainline, and
-    a2ec905d1e16 ("Bluetooth: fix kernel oops in
-    store_pending_adv_report") which is in 5.8 (and which was
-    backported to 5.7.13, 5.4.56 and 4.19.137).
-    The "fixed version" information in INTEL-SA-00435 is thus as
-    well contradictory as it mentions the issue to be fixed in 5.9
-    or later.
-  wens: |-
-    The four patches are already in net-next as of 2020-10-14 and should h=
it
-    mainline soon. As far as I can tell, ("Bluetooth: A2MP: Fix not
-    initializing all members") fixes commits going all the way back to
-    3.6, when A2MP was added.
-    Regarding the culprit commits, the first commit is fixed by a2ec905d1e=
16
-    ("Bluetooth: fix kernel oops in store_pending_adv_report"); the next
-    nine are the various "not fully initialized stack variables"; the last
-    two are the sk_filter and BT_HS ones, respectfully.
+  https://github.com/google/security-research/security/advisories/GHSA-h63=
7-c88j-47wq
+aliases:
+  GHSA-h637-c88j-47wq
 introduced-by:
-  mainline: [c215e9397b00b3045a668120ed7dbd89f2866e74, 6b44d9b8d96b37f72cc=
d7335b32f386a67b7f1f4,
-    a28381dc9ca3e54b0678e2cd7c68c1afb2d7cc76, e072f5dab22e7bf0a10daf854acc=
0fc271396ee7,
-    6113f84fc1a8962aed25f54a115b196e9aea151f, 8e2a0d92c56ec6955526a8b60838=
c9b00f70540d,
-    aa09537d80bf7e6282103618eb496f03e76f2953, 0d868de9d8760c76f6d4c6c77793=
5c05ef272caa,
-    8e05e3ba88adcf7ac644e6ef26676ea7c048a08c, 93c3e8f5c9a0e4dc6b6c93108dcf=
3ec54ab1191a,
-    dbb50887c8f619fc5c3489783ebc3122bc134a31, 6d80dfd094a7b286e95cdcac79ef=
eb7bbb4e226f]
+  mainline: dbb50887c8f619fc5c3489783ebc3122bc134a31
+
+  (no Fixed: tag matching dbb50887c8 in -next).
+
+Probably this fixes it?
+  f19425641cb2572a33cb074d5e30283720bd4d22 .. yep.
\ No newline at end of file
diff --git a/issues/CVE-2020-12352.yml b/issues/CVE-2020-12352.yml
index 63f8b60..64b731d 100644
--- a/issues/CVE-2020-12352.yml
+++ b/issues/CVE-2020-12352.yml
@@ -1,37 +1,19 @@
-description: INTEL-SA-00435
+description: |
+  BadChoice: Stack-Based Information Leak (BleedingTooth)
+  A stack-based information leak affecting Linux kernel 3.6 and higher was=
 discovered in net/bluetooth/a2mp.c.
+advisory: |
 references:
-- https://www.intel.com/content/www/us/en/security-center/advisory/intel-s=
a-00435.html
-comments:
-  debian/carnil: |-
-    CVE-2020-12351, CVE-2020-12352 and CVE-2020-24490 are three
-    issues covered by a set of commits/patches sent upstream but
-    there is no clear association from the CVEs to the commits. So
-    duplicate this entry for now to all three CVEs.
-    The commits are:
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-1-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-2-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-3-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-4-luiz.=
dentz@gmail.com/
-    which are not yet in mainline, and
-    a2ec905d1e16 ("Bluetooth: fix kernel oops in
-    store_pending_adv_report") which is in 5.8 (and which was
-    backported to 5.7.13, 5.4.56 and 4.19.137).
-    The "fixed version" information in INTEL-SA-00435 is thus as
-    well contradictory as it mentions the issue to be fixed in 5.9
-    or later.
-  wens: |-
-    The four patches are already in net-next as of 2020-10-14 and should h=
it
-    mainline soon. As far as I can tell, ("Bluetooth: A2MP: Fix not
-    initializing all members") fixes commits going all the way back to
-    3.6, when A2MP was added.
-    Regarding the culprit commits, the first commit is fixed by a2ec905d1e=
16
-    ("Bluetooth: fix kernel oops in store_pending_adv_report"); the next
-    nine are the various "not fully initialized stack variables"; the last
-    two are the sk_filter and BT_HS ones, respectfully.
+  https://github.com/google/security-research/security/advisories/GHSA-7mh=
3-gq28-gfrq
+aliases:
+  GHSA-7mh3-gq28-gfrq
 introduced-by:
-  mainline: [c215e9397b00b3045a668120ed7dbd89f2866e74, 6b44d9b8d96b37f72cc=
d7335b32f386a67b7f1f4,
-    a28381dc9ca3e54b0678e2cd7c68c1afb2d7cc76, e072f5dab22e7bf0a10daf854acc=
0fc271396ee7,
-    6113f84fc1a8962aed25f54a115b196e9aea151f, 8e2a0d92c56ec6955526a8b60838=
c9b00f70540d,
-    aa09537d80bf7e6282103618eb496f03e76f2953, 0d868de9d8760c76f6d4c6c77793=
5c05ef272caa,
-    8e05e3ba88adcf7ac644e6ef26676ea7c048a08c, 93c3e8f5c9a0e4dc6b6c93108dcf=
3ec54ab1191a,
-    dbb50887c8f619fc5c3489783ebc3122bc134a31, 6d80dfd094a7b286e95cdcac79ef=
eb7bbb4e226f]
+  mainline:
+    47f2d97d38816aaca94c9b6961c6eff1cfcd0bd6
+    8e2a0d92c56ec6955526a8b60838c9b00f70540d ?
+fixed-by:
+  probably this: eddb7732119d53400f48a02536a84c509692faa8
+
+Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Date:   Thu Aug 6 11:17:11 2020 -0700
+
+ =20
\ No newline at end of file
diff --git a/issues/CVE-2020-24490.yml b/issues/CVE-2020-24490.yml
index 63f8b60..8fe3617 100644
--- a/issues/CVE-2020-24490.yml
+++ b/issues/CVE-2020-24490.yml
@@ -1,37 +1,25 @@
-description: INTEL-SA-00435
+description: |
+  BadVibes: Heap-Based Buffer Overflow (BleedingTooth)
+  A heap-based buffer overflow affecting Linux kernel 4.19 and higher was =
discovered in net/bluetooth/hci_event.c. =20
+advisory: |
+ =20
 references:
-- https://www.intel.com/content/www/us/en/security-center/advisory/intel-s=
a-00435.html
+  https://github.com/google/security-research/security/advisories/GHSA-ccx=
2-w2r4-x649
+aliases:
+  GHSA-ccx2-w2r4-x649
 comments:
-  debian/carnil: |-
-    CVE-2020-12351, CVE-2020-12352 and CVE-2020-24490 are three
-    issues covered by a set of commits/patches sent upstream but
-    there is no clear association from the CVEs to the commits. So
-    duplicate this entry for now to all three CVEs.
-    The commits are:
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-1-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-2-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-3-luiz.=
dentz@gmail.com/
-    https://lore.kernel.org/linux-bluetooth/20200806181714.3216076-4-luiz.=
dentz@gmail.com/
-    which are not yet in mainline, and
-    a2ec905d1e16 ("Bluetooth: fix kernel oops in
-    store_pending_adv_report") which is in 5.8 (and which was
-    backported to 5.7.13, 5.4.56 and 4.19.137).
-    The "fixed version" information in INTEL-SA-00435 is thus as
-    well contradictory as it mentions the issue to be fixed in 5.9
-    or later.
-  wens: |-
-    The four patches are already in net-next as of 2020-10-14 and should h=
it
-    mainline soon. As far as I can tell, ("Bluetooth: A2MP: Fix not
-    initializing all members") fixes commits going all the way back to
-    3.6, when A2MP was added.
-    Regarding the culprit commits, the first commit is fixed by a2ec905d1e=
16
-    ("Bluetooth: fix kernel oops in store_pending_adv_report"); the next
-    nine are the various "not fully initialized stack variables"; the last
-    two are the sk_filter and BT_HS ones, respectfully.
+  Pavel Machek:
+    This actually looks like most severe from the recent bluetooth stuff.
+
+    Fix is not one-liner but also not scary. Adds checking at expected pla=
ces.
 introduced-by:
-  mainline: [c215e9397b00b3045a668120ed7dbd89f2866e74, 6b44d9b8d96b37f72cc=
d7335b32f386a67b7f1f4,
-    a28381dc9ca3e54b0678e2cd7c68c1afb2d7cc76, e072f5dab22e7bf0a10daf854acc=
0fc271396ee7,
-    6113f84fc1a8962aed25f54a115b196e9aea151f, 8e2a0d92c56ec6955526a8b60838=
c9b00f70540d,
-    aa09537d80bf7e6282103618eb496f03e76f2953, 0d868de9d8760c76f6d4c6c77793=
5c05ef272caa,
-    8e05e3ba88adcf7ac644e6ef26676ea7c048a08c, 93c3e8f5c9a0e4dc6b6c93108dcf=
3ec54ab1191a,
-    dbb50887c8f619fc5c3489783ebc3122bc134a31, 6d80dfd094a7b286e95cdcac79ef=
eb7bbb4e226f]
+  mainline:=20
+    c215e9397b00b3045a668120ed7dbd89f2866e74
+    b2cc9761f144e8ef714be8c590603073b80ddc13
+fixed-by:
+  mainline:
+    a2ec905d1e160a33b2e210e45ad30445ef26ce0e
+  4.19:
+    5df9e5613d1c51e16b1501a4c75e139fbbe0fb6c
+    -- needs to be backported to 4.4?
+   =20
\ No newline at end of file

--=20
http://www.livejournal.com/~pavelmachek

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4ixcQAKCRAw5/Bqldv6
8pSpAJwLHVmwbext1xFFAregWGN3wldrmACfWiv1mNlwfUIpk5yxce6WcZD8CUI=
=euFv
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

--XxqADVjiB4TFpRYoHrAr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5587): https://lists.cip-project.org/g/cip-dev/message=
/5587
Mute This Topic: https://lists.cip-project.org/mt/77534365/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XxqADVjiB4TFpRYoHrAr--
