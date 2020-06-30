Return-Path: <SRS0=BkBF=AL=lists.cip-project.org=bounce+64572+4870+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7937C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 30 Jun 2020 08:13:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC0120759
	for <cip-dev@archiver.kernel.org>; Tue, 30 Jun 2020 08:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MjRnZTcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC0120759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4870+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xZd0YY4521723xJWt2EXpkMu; Tue, 30 Jun 2020 01:13:26 -0700
Subject: Re: [cip-dev] [isar-cip-core PATCH 1/6] opt-security.yml: Sample settings to install security
To: cip-dev@lists.cip-project.org
From: "venkata" <venkata.pyla@toshiba-tsip.com>
X-Originating-Location: Bengaluru, Karnataka, IN (202.56.254.194)
X-Originating-Platform: Windows Chrome 83
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 30 Jun 2020 01:13:23 -0700
References: <OSBPR01MB20536DA16CE083A714433D8AD06F0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB20536DA16CE083A714433D8AD06F0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Message-ID: <15141.1593504803989680304@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UaBcW2d98ygW9cMhAF8OLSA2x4520388AA=
Content-Type: multipart/mixed; boundary="PQfhFRkChrLfgdm6KKcD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593504806;
 bh=U5cSTDxTUNPPLY2WLGoFCdPrGzm3E6H6+cjl45UyzgM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=MjRnZTcDPoDVVyLqRk+/dsCTaACPyCExoae0qP1Uv/43yEgWs6ugYRtBU/Nv80jZg0q
 Egt1UFv7pHy32rWQXbU1C823VpiyxHJZsMacbC3aFE5RKRyCsZo61bE0h1I82b8HYZRtw
 8z1Evy6WscKI2VyEf0Be+wAO8fgkMu0UybQ=

--PQfhFRkChrLfgdm6KKcD
Content-Type: multipart/alternative; boundary="xvrUSLB2W8iyN5IWS2ny"

--xvrUSLB2W8iyN5IWS2ny
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 05:26 PM, Daniel Sangorrin wrote:

>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.o=
rg]
>> On Behalf Of Jan Kiszka
>> Sent: Friday, June 26, 2020 7:41 PM
>> To: cip-dev@lists.cip-project.org; pyla venkata(=EF=BC=B4=EF=BC=B3=EF=
=BC=A9=EF=BC=B0)
>> <Venkata.Pyla@toshiba-tsip.com>
>> Cc: cip-security@lists.cip-project.org
>> Subject: Re: [cip-dev][isar-cip-core PATCH 1/6] opt-security.yml: Sampl=
e
>> settings to install security
>>=20
>> On 26.06.20 08:44, venkata wrote:
>>=20
>>> From: Kazuhiro Hayashi
>>> kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp
>>=20
>> This line seems to have been mangled. It should be in line with the
>> Signed-off-by.
>>=20
>>=20
>>> opt-security.yml: Sample settings to install security packages
>>>=20
>>> Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
>>> ---
>>> SECURITY.md | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>>> opt-security.yml | 34 +++++++++++++++++++++++++++++++
>>> 2 files changed, 86 insertions(+)
>>> create mode 100644 SECURITY.md
>>> create mode 100644 opt-security.yml
>>>=20
>>> diff --git a/SECURITY.md b/SECURITY.md new file mode 100644 index
>>> 0000000..a8bccc7
>>> --- /dev/null
>>> +++ b/SECURITY.md
>>> @@ -0,0 +1,52 @@
>>> +How to customize images for security features
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +This is the "temporal" document about how to create and use the CIP
>>> +Core generic profile images for security feature evaluation.
>>> +
>>> +Official manuals
>>> +----------------
>>> +
>>> +* isar-cip-core:
>>> + https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/README.md
>>> +* ISAR User Manual:
>>> + https://github.com/ilbers/isar/blob/master/doc/user_manual.md
>>> +
>>> +Assumed environment
>>> +-------------------
>>> +
>>> +* isar-cip-core: master branch
>>> +* Host: Debian 10 buster amd64
>>> + * Installed packages: `docker-ce`, `qemu-system`
>>> + * Users who does the following actions must be in the groups
>>> +`docker` and `kvm`
>>> +
>>> +Create kas file
>>> +---------------
>>> +
>>> +Create a kas file named `opt-security.yml` to add security settings.
>>=20
>> That file is added by this patch already.
>>=20
>>=20
>>> +
>>> +Add security packages to rootfs
>>> +-------------------------------
>>> +
>>> +Set `IMAGE_PREINSTALL` to the list of packages required to enable the
>>> +security features. This variable can be set through the kas file.
>>> +
>>> +Example:
>>> +
>>> +```
>>> +local_conf_header:
>>> + security: |
>>> + IMAGE_PREINSTALL =3D "openssl"
>>> +```
>>> +
>>> +Build images
>>> +------------
>>> +
>>> +Build images for QEMU x86 64bit machine:
>>> +
>>> + $ ./kas-docker --isar build
>>> + kas.yml:board-qemu-amd64.yml:opt-security.yml
>>> +
>>> +Run on QEMU
>>> +-----------
>>> +
>>> +Run the generated images on QEMU (x86 64bit).
>>> +
>>> + $ ./start-qemu.sh amd64
>>> diff --git a/opt-security.yml b/opt-security.yml new file mode 100644
>>> index 0000000..7c6b39c
>>> --- /dev/null
>>> +++ b/opt-security.yml
>>> @@ -0,0 +1,34 @@
>>> +#
>>> +# KAS configuration for CIP Core generic profile to enable security
>>> +features # # Copyright (c) Toshiba Corporation, 2020 # # Authors:
>>> +# Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp> # #
>>> +SPDX-License-Identifier: MIT #
>>> +
>>> +header:
>>> + version: 8
>>> +
>>> +local_conf_header:
>>> + security: |
>>> + # TODO: Add sudo or sudo-ldap
>>> + IMAGE_PREINSTALL =3D "\
>>> + openssl libssl1.1 \
>>> + fail2ban \
>>> + openssh-server openssh-sftp-server openssh-client \
>>> + syslog-ng-core syslog-ng-mod-journal \
>>> + aide aide-common \
>>> + libnftables0 nftables \
>>> + libpam-pkcs11 \
>>> + chrony \
>>> + tpm2-tools \
>>> + tpm2-abrmd \
>>> + libtss2-esys0 libtss2-udev \
>>> + libpam-cracklib \
>>> + acl \
>>> + libauparse0 audispd-plugins auditd \
>>> + uuid-runtime \
>>> + "
>>=20
>> Shouldn't we target for a security image (recipe) instead?
>>=20
>> General question: What is this series targeting? Seems patch 2 and 3 ar=
e
>> left-overs from the development. Is this an RFC series only?
>>=20
>> Jan
>=20
> It seems that opt-security.yaml was already removed in the security
> branch:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/security/ie=
c-evaluation
>=20
>=20
> Venkata-san: could you rebase your patches for the master branch?
>=20
>=20
> For example, instead of sending one patch where you add opt-security.yam=
l
> and then another patch where you remove it (which may have happened in
> your branch, but we don't care), just send the patch that uses
> core-image-security. That will make things easier to review.

I understood now, i will rebase the patches with master branch and i will =
resend the patches for review, sorry for the confusion

>=20
> Also, as we have talked in the meetings, it looks like the security laye=
r
> at the moment is just adding some packages but don't you need to add
> configuration files to harden the final file system? For example, you ma=
y
> want to change the configuration of the ssh server so that passwords are
> not accepted (only ssh keys). And the same for the rest of packages. In
> that case, you probably want to create a new kas-security.yaml.

Currently we don't have such configuration changes, but most probably in t=
he future may be after discussion with Certification Body we may need to in=
clude configurations to fullfill the security requirement, we will keep thi=
s point in security WG discussions and get some consensus.

>=20
> Thanks,
> Daniel

--xvrUSLB2W8iyN5IWS2ny
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 05:26 PM, Daniel Sangorrin wrote:<br />
<blockquote>
<blockquote>-----Original Message-----<br />From: cip-dev@lists.cip-projec=
t.org [mailto:cip-dev@lists.cip-project.org] On Behalf Of Jan Kiszka<br />S=
ent: Friday, June 26, 2020 7:41 PM<br />To: cip-dev@lists.cip-project.org; =
pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) &lt;Venkata.Pyla@toshiba=
-tsip.com&gt;<br />Cc: cip-security@lists.cip-project.org<br />Subject: Re:=
 [cip-dev][isar-cip-core PATCH 1/6] opt-security.yml: Sample settings to in=
stall security<br /><br />On 26.06.20 08:44, venkata wrote:<br />
<blockquote>From: Kazuhiro Hayashi<br />kazuhiro3.hayashi@toshiba.co.jp&lt=
;mailto:kazuhiro3.hayashi@toshiba.co.jp</blockquote>
This line seems to have been mangled. It should be in line with the Signed=
-off-by.<br /><br />
<blockquote>opt-security.yml: Sample settings to install security packages=
<br /><br />Signed-off-by: Kazuhiro Hayashi &lt;kazuhiro3.hayashi@toshiba.c=
o.jp&gt;<br />---<br />SECURITY.md | 52 +++++++++++++++++++++++++++++++++++=
+++++++++++++<br />opt-security.yml | 34 +++++++++++++++++++++++++++++++<br=
 />2 files changed, 86 insertions(+)<br />create mode 100644 SECURITY.md<br=
 />create mode 100644 opt-security.yml<br /><br />diff --git a/SECURITY.md =
b/SECURITY.md new file mode 100644 index<br />0000000..a8bccc7<br />--- /de=
v/null<br />+++ b/SECURITY.md<br />@@ -0,0 +1,52 @@<br />+How to customize =
images for security features<br />+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br />+<br />+This is the "temporal" document abou=
t how to create and use the CIP<br />+Core generic profile images for secur=
ity feature evaluation.<br />+<br />+Official manuals<br />+---------------=
-<br />+<br />+* isar-cip-core:<br />+<a href=3D"https://gitlab.com/zuka082=
8/isar-cip-core/-/blob/master/README.md" target=3D"_blank" rel=3D"noopener"=
>https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/README.md</a><br /=
>+* ISAR User Manual:<br />+<a href=3D"https://github.com/ilbers/isar/blob/=
master/doc/user_manual.md" target=3D"_blank" rel=3D"noopener">https://githu=
b.com/ilbers/isar/blob/master/doc/user_manual.md</a><br />+<br />+Assumed e=
nvironment<br />+-------------------<br />+<br />+* isar-cip-core: master b=
ranch<br />+* Host: Debian 10 buster amd64<br />+ * Installed packages: `do=
cker-ce`, `qemu-system`<br />+ * Users who does the following actions must =
be in the groups<br />+`docker` and `kvm`<br />+<br />+Create kas file<br /=
>+---------------<br />+<br />+Create a kas file named `opt-security.yml` t=
o add security settings.</blockquote>
That file is added by this patch already.<br /><br />
<blockquote>+<br />+Add security packages to rootfs<br />+----------------=
---------------<br />+<br />+Set `IMAGE_PREINSTALL` to the list of packages=
 required to enable the<br />+security features. This variable can be set t=
hrough the kas file.<br />+<br />+Example:<br />+<br />+```<br />+local_con=
f_header:<br />+ security: |<br />+ IMAGE_PREINSTALL =3D "openssl"<br />+``=
`<br />+<br />+Build images<br />+------------<br />+<br />+Build images fo=
r QEMU x86 64bit machine:<br />+<br />+ $ ./kas-docker --isar build<br />+ =
kas.yml:board-qemu-amd64.yml:opt-security.yml<br />+<br />+Run on QEMU<br /=
>+-----------<br />+<br />+Run the generated images on QEMU (x86 64bit).<br=
 />+<br />+ $ ./start-qemu.sh amd64<br />diff --git a/opt-security.yml b/op=
t-security.yml new file mode 100644<br />index 0000000..7c6b39c<br />--- /d=
ev/null<br />+++ b/opt-security.yml<br />@@ -0,0 +1,34 @@<br />+#<br />+# K=
AS configuration for CIP Core generic profile to enable security<br />+feat=
ures # # Copyright (c) Toshiba Corporation, 2020 # # Authors:<br />+# Kazuh=
iro Hayashi &lt;kazuhiro3.hayashi@toshiba.co.jp&gt; # #<br />+SPDX-License-=
Identifier: MIT #<br />+<br />+header:<br />+ version: 8<br />+<br />+local=
_conf_header:<br />+ security: |<br />+ # TODO: Add sudo or sudo-ldap<br />=
+ IMAGE_PREINSTALL =3D "\<br />+ openssl libssl1.1 \<br />+ fail2ban \<br /=
>+ openssh-server openssh-sftp-server openssh-client \<br />+ syslog-ng-cor=
e syslog-ng-mod-journal \<br />+ aide aide-common \<br />+ libnftables0 nft=
ables \<br />+ libpam-pkcs11 \<br />+ chrony \<br />+ tpm2-tools \<br />+ t=
pm2-abrmd \<br />+ libtss2-esys0 libtss2-udev \<br />+ libpam-cracklib \<br=
 />+ acl \<br />+ libauparse0 audispd-plugins auditd \<br />+ uuid-runtime =
\<br />+ "</blockquote>
Shouldn't we target for a security image (recipe) instead?<br /><br />Gene=
ral question: What is this series targeting? Seems patch 2 and 3 are left-o=
vers from the development. Is this an RFC series only?<br /><br />Jan</bloc=
kquote>
It seems that opt-security.yaml was already removed in the security branch=
:<br /><a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/t=
ree/security/iec-evaluation" target=3D"_blank" rel=3D"noopener">https://git=
lab.com/cip-project/cip-core/isar-cip-core/-/tree/security/iec-evaluation</=
a><br /><br />Venkata-san: could you rebase your patches for the master bra=
nch?<br /><br /><br />For example, instead of sending one patch where you a=
dd opt-security.yaml and then another patch where you remove it (which may =
have happened in your branch, but we don't care), just send the patch that =
uses core-image-security. That will make things easier to review.</blockquo=
te>
I understood now, i will rebase the patches with master branch and i will =
resend the patches for review, sorry for the confusion<br />
<blockquote>Also, as we have talked in the meetings, it looks like the sec=
urity layer at the moment is just adding some packages but don't you need t=
o add configuration files to harden the final file system? For example, you=
 may want to change the configuration of the ssh server so that passwords a=
re not accepted (only ssh keys). And the same for the rest of packages. In =
that case, you probably want to create a new kas-security.yaml.</blockquote=
>
Currently we don't have such configuration changes, but most probably in t=
he future may be after discussion with Certification Body we may need to in=
clude configurations to fullfill the security requirement, we will keep thi=
s point in security WG discussions and get some consensus.<br />
<blockquote>Thanks,<br />Daniel</blockquote>

--xvrUSLB2W8iyN5IWS2ny--

--PQfhFRkChrLfgdm6KKcD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4870): https://lists.cip-project.org/g/cip-dev/message=
/4870
Mute This Topic: https://lists.cip-project.org/mt/75119562/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--PQfhFRkChrLfgdm6KKcD--
