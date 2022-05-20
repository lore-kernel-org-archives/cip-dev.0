Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764EC433F5
	for <webhook@archiver.kernel.org>; Fri, 20 May 2022 08:35:21 +0000 (UTC)
Subject: Followup to "nfc: st21nfca: Fix potential buffer overflows in
 EVT_TRANSACTION" #cip
To: cip-dev@lists.cip-project.org
From: theflamefire89@gmail.com
X-Originating-Location: Dresden, Saxony, DE (217.254.146.170)
X-Originating-Platform: Linux Firefox 100
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 20 May 2022 01:35:20 -0700
Message-ID: <Tbun.1653035720797762715.tMvS@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="8sIjNJgUXU1mlnrnTofm"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 May 2022 08:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8414

--8sIjNJgUXU1mlnrnTofm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
I noticed that the mentioned patch (https://git.kernel.org/pub/scm/linux/ke=
rnel/git/cip/linux-cip.git/commit/?h=3Dlinux-4.4.y-st&id=3Db2df16de20b3f2ee=
6dbaf86b474e1bd87ddd8d51) made it into various CIP branches, e.g. linux-4.4=
.y-st.
It fixes potential OOB writes.
However it also introduces memory leaks due to the new return statements le=
aking the allocated `transaction`, i.e. it misses a ` devm_kfree (dev, tran=
saction);` in those cases.
Furthermore there is also a logic error and potential OOB read issues which=
 are fixed in various Android kernel forks. See e.g. https://android-review=
.linaro.org/plugins/gitiles/kernel/hikey-linaro/+/bf7ef8f2d57cd1f5f1846dd58=
ff9309efad58252

I haven't found patches for that in the upstream kernels and I do not know =
the policy regarding such issues / not-yet-upstream patches.
Anyway, those issues exist and at least for some there are patches and addi=
ng the missing devm_kfree is trivial, so I wanted to make you aware of that=
.

Thanks,
Flamefire

--8sIjNJgUXU1mlnrnTofm
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi all,<br />I noticed that the mentioned patch (https://git.kernel.org/=
pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=3Dlinux-4.4.y-st&amp;i=
d=3Db2df16de20b3f2ee6dbaf86b474e1bd87ddd8d51) made it into various CIP bran=
ches, e.g. linux-4.4.y-st.<br />It fixes potential OOB writes.<br />However=
 it also introduces memory leaks due to the new return statements leaking t=
he allocated `transaction`, i.e. it misses a `<span class=3D"blob-code-inne=
r blob-code-marker js-code-nav-pass " data-code-marker=3D"+"><span class=3D=
"pl-c1">devm_kfree</span>(dev, transaction);` in those cases.<br />Furtherm=
ore there is also a logic error and potential OOB read issues which are fix=
ed in various Android kernel forks. See e.g. https://android-review.linaro.=
org/plugins/gitiles/kernel/hikey-linaro/+/bf7ef8f2d57cd1f5f1846dd58ff9309ef=
ad58252<br /><br />I haven't found patches for that in the upstream kernels=
 and I do not know the policy regarding such issues / not-yet-upstream patc=
hes.<br /></span><span class=3D"blob-code-inner blob-code-marker js-code-na=
v-pass " data-code-marker=3D"+"></span><span class=3D"blob-code-inner blob-=
code-marker js-code-nav-pass " data-code-marker=3D"+">Anyway, those issues =
exist and at least for some there are patches and adding the missing </span=
><span class=3D"blob-code-inner blob-code-marker js-code-nav-pass " data-co=
de-marker=3D"+"><span class=3D"pl-c1">devm_kfree is trivial, so I wanted to=
 make you aware of that.<br /><br />Thanks,<br />Flamefire<br /></span></sp=
an><span class=3D"blob-code-inner blob-code-marker js-code-nav-pass " data-=
code-marker=3D"+"></span><span class=3D"blob-code-inner blob-code-marker js=
-code-nav-pass " data-code-marker=3D"+"><span class=3D"pl-c1"></span></span=
></p>

--8sIjNJgUXU1mlnrnTofm--

