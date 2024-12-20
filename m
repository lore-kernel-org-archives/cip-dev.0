Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC869E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 21:04:02 +0000 (UTC)
Subject: Re: Issue with the latest commit from master regarding initramfs-hook
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: Puyallup, Washington, US (174.21.60.212)
X-Originating-Platform: Mac Firefox 132
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 13:03:54 -0800
References: <473d7ab6-eb73-44d8-8611-ea7bb0aa3026@siemens.com>
In-Reply-To: <473d7ab6-eb73-44d8-8611-ea7bb0aa3026@siemens.com>
Message-ID: <734.1734728634993110433@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="96mM33MY0wsg9yg8HD3t"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Dec 2024 21:04:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17489

--96mM33MY0wsg9yg8HD3t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

I just tried to build with a clean start by removing the build directory as=
 well as the isar/ and isar-cip-core/ layers that I use in my build.

>=20
> isar-cip-core :
> url : https://gitlab.com/cip-project/cip-core/isar-cip-core.git
> #commit: 75593f244100cc726e7e337298f54f2e80b82a6d
> branch : master
>=20
> isar :
> url : https://github.com/ilbers/isar.git
> #commit: a7c4f4040b24dd5414a93ec7beb9e47bfaabca73
> branch : master
> layers :
> meta :
> meta-isar :
>=20
>=20

I use branch: master for both of them and I ran into the same issue.

Thanks,
John

--96mM33MY0wsg9yg8HD3t
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Quirin,</div>
<div>&nbsp;</div>
<div>I just tried to build with a clean start by removing the build directo=
ry as well as the isar/ and isar-cip-core/ layers that I use in my build.</=
div>
<div>&nbsp;</div>
<blockquote>
<div>
<div style=3D"color: #d4d4d4; background-color: #1e1e1e; font-family: Menlo=
, Monaco, 'Courier New', monospace; font-weight: normal; font-size: 12px; l=
ine-height: 18px; white-space: pre;">
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">isar-cip-core</span><span style=3D"color: #d4d4d4;">:</span></div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">url</span><span style=3D"color: #d4d4d4;">: </span><span style=3D"color: =
#ce9178;">https://gitlab.com/cip-project/cip-core/isar-cip-core.git</span><=
/div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #6a9955;=
">#commit: 75593f244100cc726e7e337298f54f2e80b82a6d</span></div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">branch</span><span style=3D"color: #d4d4d4;">: </span><span style=3D"colo=
r: #ce9178;">master</span></div>
<br />
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">isar</span><span style=3D"color: #d4d4d4;">:</span></div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">url</span><span style=3D"color: #d4d4d4;">: </span><span style=3D"color: =
#ce9178;">https://github.com/ilbers/isar.git</span></div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #6a9955;=
">#commit: a7c4f4040b24dd5414a93ec7beb9e47bfaabca73</span></div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">branch</span><span style=3D"color: #d4d4d4;">: </span><span style=3D"colo=
r: #ce9178;">master</span></div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">layers</span><span style=3D"color: #d4d4d4;">:</span></div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">meta</span><span style=3D"color: #d4d4d4;">:</span></div>
<div><span style=3D"color: #d4d4d4;"> </span><span style=3D"color: #569cd6;=
">meta-isar</span><span style=3D"color: #d4d4d4;">:</span></div>
<div>&nbsp;</div>
</div>
</div>
</blockquote>
<div>&nbsp;</div>
<div>I use branch: master for both of them and I ran into the same issue.</=
div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>John</div>

--96mM33MY0wsg9yg8HD3t--

