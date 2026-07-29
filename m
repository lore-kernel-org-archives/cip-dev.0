Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A762BC53200
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 04:26:49 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH v2 2/2] Enable CI image build and test support for forky
To: cip-dev@lists.cip-project.org
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (151.186.148.44)
X-Originating-Platform: Windows Chrome 150
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 28 Jul 2026 21:26:44 -0700
References: <20260728085519.3615499-1-Shivanand.Kunijadar@toshiba-tsip.com> <20260728085519.3615499-3-Shivanand.Kunijadar@toshiba-tsip.com> <1fc13594-a7c6-421c-82fc-e8953bd07458@siemens.com>
In-Reply-To: <1fc13594-a7c6-421c-82fc-e8953bd07458@siemens.com>
Message-ID: <1113502.1785299204099110509@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="kUpfkPSuwYdbIOmo6XBH"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2026 04:26:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23812

--kUpfkPSuwYdbIOmo6XBH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 08:29 AM, Jan Kiszka wrote:

>=20
> On 28.07.26 10:55, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>=20
>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>=20
>> Keep these jobs as scheduled and can be scheduled to run every week
>> just to monitor and fix if there are any issues.
>> Also set allow_failure:true for these jobs as forky is not officially
>> released and there will always be some build & test issues.
>>=20
>> It includes SWUpdate, secure boot & RB tests.
>>=20
>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com=
>
>> ---
>> .gitlab-ci.yml | 148 +++++++++++++++++++++++++++++++++++++
>> .reproducible-check-ci.yml | 72 ++++++++++++++++++
>> 2 files changed, 220 insertions(+)
>>=20
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index b53def4..b15c5da 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -8,6 +8,7 @@
>> # Jan Kiszka <jan.kiszka@siemens.com>
>> # Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> # Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>> +# Shivanand Kunijadar <shivanand.kunijadar@toshiba-tsip.com>
>> #
>> # SPDX-License-Identifier: MIT
>> #
>> @@ -63,6 +64,7 @@ default:
>> - if [ "${release}" =3D "bullseye" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/bullseye.yml"; fi
>> - if [ "${release}" =3D "bookworm" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/bookworm.yml"; fi
>> - if [ "${release}" =3D "trixie" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/trixie.yml"; fi
>> + - if [ "${release}" =3D "forky" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/forky.yml"; fi
>> - if [ "${release}" =3D "sid" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/sid.yml"; fi
>> - if [ "${encrypt}" =3D "enable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/encrypt-data.yml"; fi
>> - if [ "${factory_reset}" =3D "enable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/factory-reset.yml"; fi
>> @@ -399,6 +401,57 @@ build:qemu-arm-base-sid:
>> separate_home_partition: enable
>> deploy: enable
>>=20
>> +# forky image builds
>> +.build_base_forky:
>> + extends:
>> + - .build_base
>> + rules:
>> + - if: $CI_COMMIT_TAG
>> + when: never
>> + - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $CI_RUN_UNSTABLE'
>=20
> I meant we should migrate both forky and sid under this one
> CI_RUN_UNSTABLE variable. Now we would still have two of them and would
> need to set them both in the pipeline schedule.

My idea was as below,

- The CI variable CI_RUN_UNSTABLE_FORKY is changed to CI_RUN_UNSTABLE,

however CI_RUN_UNSTABLE_SID is not changed in this patch series, will

update in a separate patch as it is not related to this series.

And it was mentioned in the v2 patch series cover letter, I think you would=
 have missed that.

let me know if required I will change CI_RUN_UNSTABLE_SID to CI_RUN_UNSTABL=
E in this series only.

Thanks & Regards

Shivanand K

--kUpfkPSuwYdbIOmo6XBH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Tue, Jul 28, 2026 at 08:29 AM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 28.07.26 10:55, Shivanand.Kunijadar@toshiba-tsip.com wrote:<=
br />
<blockquote>From: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.=
com&gt;<br /><br />Keep these jobs as scheduled and can be scheduled to run=
 every week<br />just to monitor and fix if there are any issues.<br />Also=
 set allow_failure:true for these jobs as forky is not officially<br />rele=
ased and there will always be some build &amp; test issues.<br /><br />It i=
ncludes SWUpdate, secure boot &amp; RB tests.<br /><br />Signed-off-by: Shi=
vanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;<br />---<br /=
>.gitlab-ci.yml | 148 +++++++++++++++++++++++++++++++++++++<br />.reproduci=
ble-check-ci.yml | 72 ++++++++++++++++++<br />2 files changed, 220 insertio=
ns(+)<br /><br />diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br />index b5=
3def4..b15c5da 100644<br />--- a/.gitlab-ci.yml<br />+++ b/.gitlab-ci.yml<b=
r />@@ -8,6 +8,7 @@<br /># Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br />#=
 Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br /># Nobuhiro Iwam=
atsu &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;<br />+# Shivanand Kunijadar &=
lt;shivanand.kunijadar@toshiba-tsip.com&gt;<br />#<br /># SPDX-License-Iden=
tifier: MIT<br />#<br />@@ -63,6 +64,7 @@ default:<br />- if [ "${release}"=
 =3D "bullseye" ]; then base_yaml=3D"${base_yaml}:kas/opt/bullseye.yml"; fi=
<br />- if [ "${release}" =3D "bookworm" ]; then base_yaml=3D"${base_yaml}:=
kas/opt/bookworm.yml"; fi<br />- if [ "${release}" =3D "trixie" ]; then bas=
e_yaml=3D"${base_yaml}:kas/opt/trixie.yml"; fi<br />+ - if [ "${release}" =
=3D "forky" ]; then base_yaml=3D"${base_yaml}:kas/opt/forky.yml"; fi<br />-=
 if [ "${release}" =3D "sid" ]; then base_yaml=3D"${base_yaml}:kas/opt/sid.=
yml"; fi<br />- if [ "${encrypt}" =3D "enable" ]; then base_yaml=3D"${base_=
yaml}:kas/opt/encrypt-data.yml"; fi<br />- if [ "${factory_reset}" =3D "ena=
ble" ]; then base_yaml=3D"${base_yaml}:kas/opt/factory-reset.yml"; fi<br />=
@@ -399,6 +401,57 @@ build:qemu-arm-base-sid:<br />separate_home_partition:=
 enable<br />deploy: enable<br /><br />+# forky image builds<br />+.build_b=
ase_forky:<br />+ extends:<br />+ - .build_base<br />+ rules:<br />+ - if: =
$CI_COMMIT_TAG<br />+ when: never<br />+ - if: '$CI_PIPELINE_SOURCE =3D=3D =
"schedule" &amp;&amp; $CI_RUN_UNSTABLE'</blockquote>
I meant we should migrate both forky and sid under this one<br />CI_RUN_UNS=
TABLE variable. Now we would still have two of them and would<br />need to =
set them both in the pipeline schedule.</blockquote>
</div>
<div>My idea was as below,&nbsp;</div>
<div>
<p class=3D"MsoPlainText">- The CI variable CI_RUN_UNSTABLE_FORKY is change=
d to CI_RUN_UNSTABLE,</p>
<p class=3D"MsoPlainText"><span style=3D"mso-spacerun: yes;">&nbsp; </span>=
however CI_RUN_UNSTABLE_SID is not changed in this patch series, will</p>
<p class=3D"MsoPlainText"><span style=3D"mso-spacerun: yes;">&nbsp; </span>=
update in a separate patch as it is not related to this series.</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">And it was mentioned in the v2 patch series cover=
 letter, I think you would have missed that.&nbsp;</p>
<p class=3D"MsoPlainText">let me know if required I will change CI_RUN_UNST=
ABLE_SID to CI_RUN_UNSTABLE in this series only.&nbsp;</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">Thanks &amp; Regards</p>
<p class=3D"MsoPlainText">Shivanand K</p>
</div>

--kUpfkPSuwYdbIOmo6XBH--

