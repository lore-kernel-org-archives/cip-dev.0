Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA9C5B567
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 06:17:33 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH v3 0/3] Enable debian forky build & test support
To: cip-dev@lists.cip-project.org
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (151.186.148.44)
X-Originating-Platform: Windows Chrome 151
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 23:17:27 -0700
References: <20260811090421.3547180-1-Shivanand.Kunijadar@toshiba-tsip.com> <c8b01319-b1a0-4d43-9707-b12acb2ff19f@siemens.com>
In-Reply-To: <c8b01319-b1a0-4d43-9707-b12acb2ff19f@siemens.com>
Message-ID: <1473907.1786515447555873268@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="mvkjUvu1dKiSV0NEmArS"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Aug 2026 06:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23902

--mvkjUvu1dKiSV0NEmArS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:09 AM, Jan Kiszka wrote:

>=20
> On 11.08.26 11:04, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>=20
>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>=20
>> This patch series adds the debian forky based image build & CI test
>> support.
>>=20
>> It enables SWUpdate, secure boot, security tests in LAVA and RB in gitla=
b
>> CI.
>>=20
>> NOTE:
>> - The existing .reproducible-check-ci.yml is updated to support forky
>> images reproducibility check. No need to add the exta scheduled pipeline
>> for forky, the current scheduled pipeline covers both trixie and
>> forky. The forky builds and RB tests are kept with allowed failure
>> option as true.
>> - Updated authors list for .gitlab-ci.yml & .reproducible-check-ci.yml
>>=20
>> Shivanand Kunijadar (3):
>> .gitlab-cip.yml: Change CI variable to CI_RUN_UNSTABLE
>> Enable the support of Debian forky based builds
>> Enable CI image build and test support for forky
>>=20
>> .gitlab-ci.yml | 152 +++++++++++++++++-
>> .reproducible-check-ci.yml | 72 +++++++++
>> Kconfig | 4 +
>> conf/distro/cip-core-forky.conf | 13 ++
>> kas/opt/forky.yml | 15 ++
>> .../files/forky/PkKek-1-snakeoil.key | 30 ++++
>> .../files/forky/PkKek-1-snakeoil.pem | 23 +++
>> .../swupdate-certificates/files/forky | 1 +
>> start-qemu.sh | 2 +
>> 9 files changed, 310 insertions(+), 2 deletions(-)
>> create mode 100644 conf/distro/cip-core-forky.conf
>> create mode 100644 kas/opt/forky.yml
>> create mode 100644
>> recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
>> create mode 100644
>> recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
>> create mode 120000 recipes-devtools/swupdate-certificates/files/forky
>=20
> Thanks, applied.

Thank you.

You may need to update CI variable in pipeline schedules=C2=A0 if not updat=
ed.
please change CI_RUN_UNSTABLE_SID to CI_RUN_UNSTABLE which triggers both fo=
rky & sid jobs.

Also change the name "Weekly Debian sid & testing builds & checks" to inclu=
de forky as well.

Thanks & Regards
Shivanand K

--mvkjUvu1dKiSV0NEmArS
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Tue, Aug 11, 2026 at 10:09 AM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 11.08.26 11:04, Shivanand.Kunijadar@toshiba-tsip.com wrote:<=
br />
<blockquote>From: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.=
com&gt;<br /><br />This patch series adds the debian forky based image buil=
d &amp; CI test support.<br /><br />It enables SWUpdate, secure boot, secur=
ity tests in LAVA and RB in gitlab CI.<br /><br />NOTE:<br />- The existing=
 .reproducible-check-ci.yml is updated to support forky<br />images reprodu=
cibility check. No need to add the exta scheduled pipeline<br />for forky, =
the current scheduled pipeline covers both trixie and<br />forky. The forky=
 builds and RB tests are kept with allowed failure<br />option as true.<br =
/>- Updated authors list for .gitlab-ci.yml &amp; .reproducible-check-ci.ym=
l<br /><br />Shivanand Kunijadar (3):<br />.gitlab-cip.yml: Change CI varia=
ble to CI_RUN_UNSTABLE<br />Enable the support of Debian forky based builds=
<br />Enable CI image build and test support for forky<br /><br />.gitlab-c=
i.yml | 152 +++++++++++++++++-<br />.reproducible-check-ci.yml | 72 +++++++=
++<br />Kconfig | 4 +<br />conf/distro/cip-core-forky.conf | 13 ++<br />kas=
/opt/forky.yml | 15 ++<br />.../files/forky/PkKek-1-snakeoil.key | 30 ++++<=
br />.../files/forky/PkKek-1-snakeoil.pem | 23 +++<br />.../swupdate-certif=
icates/files/forky | 1 +<br />start-qemu.sh | 2 +<br />9 files changed, 310=
 insertions(+), 2 deletions(-)<br />create mode 100644 conf/distro/cip-core=
-forky.conf<br />create mode 100644 kas/opt/forky.yml<br />create mode 1006=
44 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key<br=
 />create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKe=
k-1-snakeoil.pem<br />create mode 120000 recipes-devtools/swupdate-certific=
ates/files/forky</blockquote>
Thanks, applied.</blockquote>
Thank you.&nbsp;</div>
<div>&nbsp;</div>
<div>You may need to update CI variable in pipeline schedules&nbsp; if not =
updated.&nbsp;</div>
<div>please change CI_RUN_UNSTABLE_SID to CI_RUN_UNSTABLE which triggers bo=
th forky &amp; sid jobs.&nbsp;</div>
<div>&nbsp;</div>
<div>Also change the name "Weekly Debian sid &amp; testing builds &amp; che=
cks" to include forky as well.</div>
<div>&nbsp;</div>
<div>Thanks &amp; Regards</div>
<div>Shivanand K</div>

--mvkjUvu1dKiSV0NEmArS--

