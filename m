Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6FCC5AC67
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 09:21:06 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH v2 2/2] Enable CI image build and test support for forky
To: cip-dev@lists.cip-project.org
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (151.186.148.44)
X-Originating-Platform: Windows Chrome 151
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 02:20:56 -0700
References: <20260728085519.3615499-1-Shivanand.Kunijadar@toshiba-tsip.com> <20260728085519.3615499-3-Shivanand.Kunijadar@toshiba-tsip.com> <1fc13594-a7c6-421c-82fc-e8953bd07458@siemens.com> <1113502.1785299204099110509@lists.cip-project.org> <1187398.1785750444675558966@lists.cip-project.org> <c703b275-cd05-456a-8aa0-724dfee32911@siemens.com>
In-Reply-To: <c703b275-cd05-456a-8aa0-724dfee32911@siemens.com>
Message-ID: <1399990.1786440056585870002@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="npUuK3zpKi4p53pAaKi7"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 09:21:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23895

--npUuK3zpKi4p53pAaKi7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Mon, Aug 10, 2026 at 07:46 AM, Jan Kiszka wrote:

>=20
> On 03.08.26 11:47, Kunijadar Shivanand wrote:
>=20
>> Hi Jan,
>>=20
>> On Tue, Jul 28, 2026 at 09:26 PM, Kunijadar Shivanand wrote:
>>=20
>> On Tue, Jul 28, 2026 at 08:29 AM, Jan Kiszka wrote:
>>=20
>> On 28.07.26 10:55, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>=20
>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>=20
>> Keep these jobs as scheduled and can be scheduled to run
>> every week
>> just to monitor and fix if there are any issues.
>> Also set allow_failure:true for these jobs as forky is not
>> officially
>> released and there will always be some build & test issues.
>>=20
>> It includes SWUpdate, secure boot & RB tests.
>>=20
>> Signed-off-by: Shivanand Kunijadar
>> <Shivanand.Kunijadar@toshiba-tsip.com>
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
>>=20
>> I meant we should migrate both forky and sid under this one
>> CI_RUN_UNSTABLE variable. Now we would still have two of them
>> and would
>> need to set them both in the pipeline schedule.
>>=20
>> My idea was as below,
>>=20
>> - The CI variable CI_RUN_UNSTABLE_FORKY is changed to CI_RUN_UNSTABLE,
>>=20
>> however CI_RUN_UNSTABLE_SID is not changed in this patch series, will
>>=20
>> update in a separate patch as it is not related to this series.
>>=20
>>=20
>>=20
>> And it was mentioned in the v2 patch series cover letter, I think
>> you would have missed that.
>>=20
>> let me know if required I will change CI_RUN_UNSTABLE_SID to
>> CI_RUN_UNSTABLE in this series only.
>>=20
>>=20
>>=20
>> Any comments on this? Shall i include the above change in this patch
>> series?
>>=20
>> please let me know, will send v3 patch series accordingly.
>=20
> Please rename CI_RUN_UNSTABLE_SID to CI_RUN_UNSTABLE before introducing
> forky as another user. Will easy to pipeline maintenance.

Thanks, fixed in v3 patch series.
please check it.

Thanks & Regards
Shivanand K

--npUuK3zpKi4p53pAaKi7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Jan,</div>
<div>&nbsp;</div>
<div>On Mon, Aug 10, 2026 at 07:46 AM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 03.08.26 11:47, Kunijadar Shivanand wrote:<br />
<blockquote>Hi Jan,&nbsp;<br />&nbsp;<br />On Tue, Jul 28, 2026 at 09:26 PM=
, Kunijadar Shivanand wrote:<br /><br />On Tue, Jul 28, 2026 at 08:29 AM, J=
an Kiszka wrote:<br /><br />On 28.07.26 10:55, Shivanand.Kunijadar@toshiba-=
tsip.com wrote:<br /><br />From: Shivanand Kunijadar &lt;Shivanand.Kunijada=
r@toshiba-tsip.com&gt;<br /><br />Keep these jobs as scheduled and can be s=
cheduled to run<br />every week<br />just to monitor and fix if there are a=
ny issues.<br />Also set allow_failure:true for these jobs as forky is not<=
br />officially<br />released and there will always be some build &amp; tes=
t issues.<br /><br />It includes SWUpdate, secure boot &amp; RB tests.<br /=
><br />Signed-off-by: Shivanand Kunijadar<br />&lt;Shivanand.Kunijadar@tosh=
iba-tsip.com&gt;<br />---<br />.gitlab-ci.yml | 148 +++++++++++++++++++++++=
++++++++++++++<br />.reproducible-check-ci.yml | 72 ++++++++++++++++++<br /=
>2 files changed, 220 insertions(+)<br /><br />diff --git a/.gitlab-ci.yml =
b/.gitlab-ci.yml<br />index b53def4..b15c5da 100644<br />--- a/.gitlab-ci.y=
ml<br />+++ b/.gitlab-ci.yml<br />@@ -8,6 +8,7 @@<br /># Jan Kiszka &lt;jan=
.kiszka@siemens.com&gt;<br /># Quirin Gylstorff &lt;quirin.gylstorff@siemen=
s.com&gt;<br /># Nobuhiro Iwamatsu &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;=
<br />+# Shivanand Kunijadar &lt;shivanand.kunijadar@toshiba-tsip.com&gt;<b=
r />#<br /># SPDX-License-Identifier: MIT<br />#<br />@@ -63,6 +64,7 @@ def=
ault:<br />- if [ "${release}" =3D "bullseye" ]; then<br />base_yaml=3D"${b=
ase_yaml}:kas/opt/bullseye.yml"; fi<br />- if [ "${release}" =3D "bookworm"=
 ]; then<br />base_yaml=3D"${base_yaml}:kas/opt/bookworm.yml"; fi<br />- if=
 [ "${release}" =3D "trixie" ]; then<br />base_yaml=3D"${base_yaml}:kas/opt=
/trixie.yml"; fi<br />+ - if [ "${release}" =3D "forky" ]; then<br />base_y=
aml=3D"${base_yaml}:kas/opt/forky.yml"; fi<br />- if [ "${release}" =3D "si=
d" ]; then<br />base_yaml=3D"${base_yaml}:kas/opt/sid.yml"; fi<br />- if [ =
"${encrypt}" =3D "enable" ]; then<br />base_yaml=3D"${base_yaml}:kas/opt/en=
crypt-data.yml"; fi<br />- if [ "${factory_reset}" =3D "enable" ]; then<br =
/>base_yaml=3D"${base_yaml}:kas/opt/factory-reset.yml"; fi<br />@@ -399,6 +=
401,57 @@ build:qemu-arm-base-sid:<br />separate_home_partition: enable<br =
/>deploy: enable<br /><br />+# forky image builds<br />+.build_base_forky:<=
br />+ extends:<br />+ - .build_base<br />+ rules:<br />+ - if: $CI_COMMIT_=
TAG<br />+ when: never<br />+ - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" =
&amp;&amp; $CI_RUN_UNSTABLE'<br /><br />I meant we should migrate both fork=
y and sid under this one<br />CI_RUN_UNSTABLE variable. Now we would still =
have two of them<br />and would<br />need to set them both in the pipeline =
schedule.<br /><br />My idea was as below,&nbsp;<br /><br />- The CI variab=
le CI_RUN_UNSTABLE_FORKY is changed to CI_RUN_UNSTABLE,<br /><br />&nbsp; h=
owever CI_RUN_UNSTABLE_SID is not changed in this patch series, will<br /><=
br />&nbsp; update in a separate patch as it is not related to this series.=
<br /><br />&nbsp;<br /><br />And it was mentioned in the v2 patch series c=
over letter, I think<br />you would have missed that.&nbsp;<br /><br />let =
me know if required I will change CI_RUN_UNSTABLE_SID to<br />CI_RUN_UNSTAB=
LE in this series only.<br /><br />&nbsp;<br /><br />Any comments on this? =
Shall i include the above change in this patch<br />series?&nbsp;<br /><br =
/>please let me know, will send v3 patch series accordingly.&nbsp;</blockqu=
ote>
Please rename CI_RUN_UNSTABLE_SID to CI_RUN_UNSTABLE before introducing<br =
/>forky as another user. Will easy to pipeline maintenance.</blockquote>
Thanks, fixed in v3 patch series.&nbsp;</div>
<div>please check it.&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks &amp; Regards</div>
<div>Shivanand K</div>

--npUuK3zpKi4p53pAaKi7--

