Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB3C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 09:43:56 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH v2] .gitlab-ci.yml: Override default release with sid
To: cip-dev@lists.cip-project.org
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (151.186.148.44)
X-Originating-Platform: Windows Chrome 150
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 02:43:55 -0700
References: <20260723050940.2447738-1-Shivanand.Kunijadar@toshiba-tsip.com> <666ae976-6e22-476b-8d20-9cccf13e1dcd@siemens.com> <8f864151-9303-4ec5-9459-9d326cbd75eb@siemens.com>
In-Reply-To: <8f864151-9303-4ec5-9459-9d326cbd75eb@siemens.com>
Message-ID: <1062711.1785145435514787811@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="4VpHRqwGtq3CggSSiSsM"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 09:43:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23756

--4VpHRqwGtq3CggSSiSsM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 11:04 PM, Jan Kiszka wrote:

>=20
> On 23.07.26 12:47, Jan Kiszka wrote:
>=20
>> On 23.07.26 07:09, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>=20
>>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>=20
>>> By default, the release is set to trixie, pass release as sid to
>>> override it for sid based test targets.
>>>=20
>>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.co=
m>
>>> ---
>>> .gitlab-ci.yml | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>=20
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index 5a20ad6..b53def4 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -740,6 +740,7 @@ test:qemu-amd64-IEC-sid:
>>> - .test-cip-core-sid
>>> variables:
>>> target: qemu-amd64
>>> + release: sid
>>> test_function: IEC
>>> iec_test_timeout: 40
>>>=20
>>> @@ -749,6 +750,7 @@ test:qemu-arm64-IEC-sid:
>>> needs: ["build:qemu-arm64-base-sid"]
>>> variables:
>>> target: qemu-arm64
>>> + release: sid
>>> test_function: IEC
>>> iec_test_timeout: 40
>>>=20
>>> @@ -758,6 +760,7 @@ test:qemu-arm-IEC-sid:
>>> needs: ["build:qemu-arm-base-sid"]
>>> variables:
>>> target: qemu-arm
>>> + release: sid
>>> test_function: IEC
>>> iec_test_timeout: 40
>>=20
>> Thanks, applied with a slightly adjusted subject ("Actually set release
>> to sid for sid targets").
>=20
> But what is now the expected state of the pipeline? It's currently
> failing in all tests:
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2704797=
364
>=20

>=20
> Is this due to changes in sid or due to still missing patches to the CI
> infrastructure?

Thanks, I had a look on the failures.

For amd64, it's an infrastructure error. The job is failed because of not f=
inding "sid-ovmf/OVMF_CODE_4M.secboot.fd" file in the LAVA QEMU devices. Th=
e QEMU devices in LAVA needs to include sid (also forky) OVMF keys. I've al=
ready created an MR to update this here https://gitlab.com/cip-project/cip-=
testing/lava-docker/-/merge_requests/57.=C2=A0 I'll follow-up with Chris on=
 this.

For arm64/armhf, the LAVA job is failed due to timeout. currently the timeo=
ut of 40 mins is set to security jobs but it is not sufficient at the momen=
t. It seems the audit related security tests are taking more time and causi=
ng this issue.
I tried incrementing timeout to 50 mins but no luck. It needs further inves=
tigation on this.

There is no issues in image boot, data encryption and secure boot etc.

>=20
> Please also have a look at the even more important inclusion of forky
> soon. This is where we need to be ready for testing as well. Could
> become part of those weekly runs as well, at least until it goes into
> stabilization in spring next year.

Yeah, understood. I'm working on it. will send the patches soon.

>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center

--4VpHRqwGtq3CggSSiSsM
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Sun, Jul 26, 2026 at 11:04 PM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 23.07.26 12:47, Jan Kiszka wrote:<br />
<blockquote>On 23.07.26 07:09, Shivanand.Kunijadar@toshiba-tsip.com wrote:<=
br />
<blockquote>From: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.=
com&gt;<br /><br />By default, the release is set to trixie, pass release a=
s sid to<br />override it for sid based test targets.<br /><br />Signed-off=
-by: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;<br />=
---<br />.gitlab-ci.yml | 3 +++<br />1 file changed, 3 insertions(+)<br /><=
br />diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br />index 5a20ad6..b53de=
f4 100644<br />--- a/.gitlab-ci.yml<br />+++ b/.gitlab-ci.yml<br />@@ -740,=
6 +740,7 @@ test:qemu-amd64-IEC-sid:<br />- .test-cip-core-sid<br />variabl=
es:<br />target: qemu-amd64<br />+ release: sid<br />test_function: IEC<br =
/>iec_test_timeout: 40<br /><br />@@ -749,6 +750,7 @@ test:qemu-arm64-IEC-s=
id:<br />needs: ["build:qemu-arm64-base-sid"]<br />variables:<br />target: =
qemu-arm64<br />+ release: sid<br />test_function: IEC<br />iec_test_timeou=
t: 40<br /><br />@@ -758,6 +760,7 @@ test:qemu-arm-IEC-sid:<br />needs: ["b=
uild:qemu-arm-base-sid"]<br />variables:<br />target: qemu-arm<br />+ relea=
se: sid<br />test_function: IEC<br />iec_test_timeout: 40</blockquote>
Thanks, applied with a slightly adjusted subject ("Actually set release<br =
/>to sid for sid targets").</blockquote>
But what is now the expected state of the pipeline? It's currently<br />fai=
ling in all tests:<br /><br /><a href=3D"https://gitlab.com/cip-project/cip=
-core/isar-cip-core/-/pipelines/2704797364" target=3D"_blank" rel=3D"noopen=
er">https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/27047=
97364</a></blockquote>
</div>
<div>
<blockquote>Is this due to changes in sid or due to still missing patches t=
o the CI<br />infrastructure?</blockquote>
</div>
<div>Thanks, I had a look on the failures.&nbsp;</div>
<div>&nbsp;</div>
<div>For amd64, it's an infrastructure error. The job is failed because of =
not finding "sid-ovmf/OVMF_CODE_4M.secboot.fd" file in the LAVA QEMU device=
s. The QEMU devices in LAVA needs to include sid (also forky) OVMF keys. I'=
ve already created an MR to update this here <a href=3D"https://gitlab.com/=
cip-project/cip-testing/lava-docker/-/merge_requests/57" target=3D"_blank" =
rel=3D"noopener">https://gitlab.com/cip-project/cip-testing/lava-docker/-/m=
erge_requests/57</a>.&nbsp; I'll follow-up with Chris on this.&nbsp;</div>
<div>&nbsp;</div>
<div>For arm64/armhf, the LAVA job is failed due to timeout. currently the =
timeout of 40 mins is set to security jobs but it is not sufficient at the =
moment. It seems the audit related security tests are taking more time and =
causing this issue.</div>
<div>I tried incrementing timeout to 50 mins but no luck. It needs further =
investigation on this.&nbsp;</div>
<div>&nbsp;</div>
<div>There is no issues in image boot, data encryption and secure boot etc.=
&nbsp;&nbsp;</div>
<div><br />
<blockquote>Please also have a look at the even more important inclusion of=
 forky<br />soon. This is where we need to be ready for testing as well. Co=
uld<br />become part of those weekly runs as well, at least until it goes i=
nto<br />stabilization in spring next year.</blockquote>
</div>
<div>&nbsp;</div>
<div>Yeah, understood. I'm working on it. will send the patches soon.</div>
<div><br />
<blockquote>Jan<br /><br />-- <br />Siemens AG, Foundational Technologies<b=
r />Linux Expert Center</blockquote>
</div>

--4VpHRqwGtq3CggSSiSsM--

