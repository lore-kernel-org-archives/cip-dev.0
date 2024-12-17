Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E2E7717F
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 17:23:19 +0000 (UTC)
Subject: Re: Issue with the latest commit from master regarding initramfs-hook
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: Puyallup, Washington, US (174.21.60.212)
X-Originating-Platform: Mac Firefox 132
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 17 Dec 2024 09:23:14 -0800
References: <2bbf9009-2fe9-4227-bc1f-829fed0c1042@siemens.com>
In-Reply-To: <2bbf9009-2fe9-4227-bc1f-829fed0c1042@siemens.com>
Message-ID: <4730.1734456194616280646@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="QtOOeC0zq7BbJCFhRxmD"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 17:23:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17439

--QtOOeC0zq7BbJCFhRxmD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the insight. I see the updated isar reference now.

However I do see some issue when updating the isar version in my builds. I =
am seeing the following

>=20
> ERROR: Task
> (mc:installer-target:/home/ubuntu/workspace/john-sandbox/build/../meta-te=
st/recipes-core/images/test-image-base.bb:do_rootfs_install)
> failed with exit code '1'
> NOTE: Tasks Summary: Attempted 298 tasks of which 235 didn't need to be
> rerun and 1 failed.
> WARNING:
> /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/=
test-image-base-x86_64-sb/1.0-r0/rootfs/sys
> left mounted, unmounting...
> WARNING:
> /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/=
test-image-base-x86_64-sb/1.0-r0/rootfs/proc
> left mounted, unmounting...
> ERROR: Command 'sudo umount
> /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/=
test-image-base-x86_64-sb/1.0-r0/rootfs/proc'
> returned non-zero exit status 32.
> WARNING:
> /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/=
test-image-base-x86_64-sb/1.0-r0/rootfs/dev/shm
> left mounted, unmounting...
> ERROR: Command 'sudo umount
> /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/=
test-image-base-x86_64-sb/1.0-r0/rootfs/dev/shm'
> returned non-zero exit status 32.
> WARNING:
> /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/=
test-image-base-x86_64-sb/1.0-r0/rootfs/dev
> left mounted, unmounting...
> ERROR: Command 'sudo umount
> /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/=
test-image-base-x86_64-sb/1.0-r0/rootfs/dev'
> returned non-zero exit status 32.
>=20
>=20

I think I've seen previous message in the email list about this issue but c=
an't recall if there's a resolution.

Thanks,
John

--QtOOeC0zq7BbJCFhRxmD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Thanks for the insight. I see the updated isar reference now.</div>
<div>&nbsp;</div>
<div>However I do see some issue when updating the isar version in my build=
s. I am seeing the following</div>
<div>&nbsp;</div>
<blockquote>
<div>ERROR: Task (mc:installer-target:/home/ubuntu/workspace/john-sandbox/b=
uild/../meta-test/recipes-core/images/test-image-base.bb:do_rootfs_install)=
 failed with exit code '1'<br />NOTE: Tasks Summary: Attempted 298 tasks of=
 which 235 didn't need to be rerun and 1 failed.<br />WARNING: /home/ubuntu=
/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/test-image-bas=
e-x86_64-sb/1.0-r0/rootfs/sys left mounted, unmounting...<br />WARNING: /ho=
me/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/test-=
image-base-x86_64-sb/1.0-r0/rootfs/proc left mounted, unmounting...<br />ER=
ROR: Command 'sudo umount /home/ubuntu/workspace/john-sandbox/build/tmp/wor=
k/debian-bookworm-amd64/test-image-base-x86_64-sb/1.0-r0/rootfs/proc' retur=
ned non-zero exit status 32.<br />WARNING: /home/ubuntu/workspace/john-sand=
box/build/tmp/work/debian-bookworm-amd64/test-image-base-x86_64-sb/1.0-r0/r=
ootfs/dev/shm left mounted, unmounting...<br />ERROR: Command 'sudo umount =
/home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-bookworm-amd64/te=
st-image-base-x86_64-sb/1.0-r0/rootfs/dev/shm' returned non-zero exit statu=
s 32.<br />WARNING: /home/ubuntu/workspace/john-sandbox/build/tmp/work/debi=
an-bookworm-amd64/test-image-base-x86_64-sb/1.0-r0/rootfs/dev left mounted,=
 unmounting...<br />ERROR: Command 'sudo umount /home/ubuntu/workspace/john=
-sandbox/build/tmp/work/debian-bookworm-amd64/test-image-base-x86_64-sb/1.0=
-r0/rootfs/dev' returned non-zero exit status 32.</div>
<div>&nbsp;</div>
</blockquote>
<div>&nbsp;</div>
<div>I think I've seen previous message in the email list about this issue =
but can't recall if there's a resolution.</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>John</div>

--QtOOeC0zq7BbJCFhRxmD--

