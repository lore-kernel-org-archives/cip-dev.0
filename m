Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0184C54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 05:47:28 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH v1 2/2] Enable CI image build and test support for forky
To: cip-dev@lists.cip-project.org
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (151.186.148.44)
X-Originating-Platform: Windows Chrome 150
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 22:47:24 -0700
References: <20260727141136.1773671-1-Shivanand.Kunijadar@toshiba-tsip.com> <20260727141136.1773671-3-Shivanand.Kunijadar@toshiba-tsip.com> <8630a39b-ab0f-4754-a7ba-364be3cd6bc8@siemens.com>
In-Reply-To: <8630a39b-ab0f-4754-a7ba-364be3cd6bc8@siemens.com>
Message-ID: <1092128.1785217644697002949@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="MwjK7mcTqjK8p3dRhb3F"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 05:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23790

--MwjK7mcTqjK8p3dRhb3F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 10:10 AM, Jan Kiszka wrote:

>=20
> On 27.07.26 16:11, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>=20
>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>=20
>> Keep these jobs as scheduled and can be scheduled to run every week
>> just to monitor and fix if there are any issues.
>> Also set allow_failure:true for these jobs as forky is not officially
>> released and there will always be some build & test issues.
>>=20
>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com=
>
>> ---
>> .gitlab-ci.yml | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 93 insertions(+)
>>=20
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index b53def4..977ae01 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -64,6 +64,7 @@ default:
>> - if [ "${release}" =3D "bookworm" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/bookworm.yml"; fi
>> - if [ "${release}" =3D "trixie" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/trixie.yml"; fi
>> - if [ "${release}" =3D "sid" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/sid.yml"; fi
>> + - if [ "${release}" =3D "forky" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/forky.yml"; fi
>=20
> ordering

Thanks, I'll fix it.

>=20
>=20
>> - if [ "${encrypt}" =3D "enable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/encrypt-data.yml"; fi
>> - if [ "${factory_reset}" =3D "enable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/factory-reset.yml"; fi
>> - if [ "${watchdog}" =3D "disable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>> @@ -399,6 +400,57 @@ build:qemu-arm-base-sid:
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
>> + - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $CI_RUN_UNSTABLE_FORKY=
'
>=20
> We should handle forky and sid identical for now, thus should likely use
> generic CI_RUN_UNSTABLE for both. Forky can then be moved out of this
> mode somewhere next year and become another regular test target in the
> pipeline, sid will always remain there.

Sure, will change it to CI_RUN_UNSTABLE for both forky & sid.

>=20
>=20
>> + - if: $CI_COMMIT_BRANCH !=3D "master"
>> + when: never
>> + allow_failure: true
>> +
>> +build:qemu-amd64-base-forky:
>> + extends:
>> + - .build_base_forky
>> + variables:
>> + target: qemu-amd64
>> + use_rt: disable
>> + release: forky
>> + extension: security
>> + security_test: enable
>> + build_updates: enable
>> + separate_home_partition: enable
>> + deploy: enable
>> +
>> +build:qemu-arm64-base-forky:
>> + extends:
>> + - .build_base_forky
>> + variables:
>> + target: qemu-arm64
>> + use_rt: disable
>> + release: forky
>> + extension: security
>> + security_test: enable
>> + build_updates: enable
>> + separate_home_partition: enable
>> + deploy: enable
>> +
>> +build:qemu-arm-base-forky:
>> + extends:
>> + - .build_base_forky
>> + variables:
>> + target: qemu-arm
>> + extension: security
>> + security_test: enable
>> + use_rt: disable
>> + release: forky
>> + build_updates: enable
>> + separate_home_partition: enable
>> + deploy: enable
>> +
>> .test-cip-core:
>> stage: test
>> image: $CI_REGISTRY_IMAGE/lavacli
>> @@ -764,6 +816,47 @@ test:qemu-arm-IEC-sid:
>> test_function: IEC
>> iec_test_timeout: 40
>>=20
>> +# Tests for forky images
>> +.test-cip-core-forky:
>> + extends:
>> + - .test-cip-core
>> + rules:
>> + - if: $CI_COMMIT_TAG
>> + when: never
>> + - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $CI_RUN_UNSTABLE_FORKY=
'
>> + - if: $CI_COMMIT_BRANCH !=3D "master"
>> + when: never
>> + allow_failure: true
>> +
>> +test:qemu-amd64-IEC-forky:
>> + extends:
>> + - .test-cip-core-forky
>> + variables:
>> + target: qemu-amd64
>> + release: forky
>> + test_function: IEC
>> + iec_test_timeout: 40
>> +
>> +test:qemu-arm64-IEC-forky:
>> + extends:
>> + - .test-cip-core-forky
>> + needs: ["build:qemu-arm64-base-forky"]
>> + variables:
>> + target: qemu-arm64
>> + release: forky
>> + test_function: IEC
>> + iec_test_timeout: 40
>> +
>> +test:qemu-arm-IEC-forky:
>> + extends:
>> + - .test-cip-core-forky
>> + needs: ["build:qemu-arm-base-forky"]
>> + variables:
>> + target: qemu-arm
>> + release: forky
>> + test_function: IEC
>> + iec_test_timeout: 40
>> +
>> cve-checks:
>> stage: cve-check
>> needs: []
>=20
> I'm still wondering what the added value of testing sid for us is. I
> would rather consider to invest our CI time into running more tests with
> forky, like some more SWUpdate checks and/or reproducibility.

Understood, we can add more tests like SWUpdate, secure boot and RB builds =
for forky. I will include them in v2 patch.

considering the value of testing for sid,
- The latest updates/fixes to any package will appear in sid before forky.=
=C2=A0As a community we can test early and report issues and also contribut=
e to Debian to fix the issues if required.

please note we have only minimal tests for sid now and also running it week=
ly. if required we can still remove the sid testing from CI, kindly let me =
know.

Thanks & Regards
Shivanand K

--MwjK7mcTqjK8p3dRhb3F
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Mon, Jul 27, 2026 at 10:10 AM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 27.07.26 16:11, Shivanand.Kunijadar@toshiba-tsip.com wrote:<=
br />
<blockquote>From: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.=
com&gt;<br /><br />Keep these jobs as scheduled and can be scheduled to run=
 every week<br />just to monitor and fix if there are any issues.<br />Also=
 set allow_failure:true for these jobs as forky is not officially<br />rele=
ased and there will always be some build &amp; test issues.<br /><br />Sign=
ed-off-by: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;=
<br />---<br />.gitlab-ci.yml | 93 ++++++++++++++++++++++++++++++++++++++++=
++++++++++<br />1 file changed, 93 insertions(+)<br /><br />diff --git a/.g=
itlab-ci.yml b/.gitlab-ci.yml<br />index b53def4..977ae01 100644<br />--- a=
/.gitlab-ci.yml<br />+++ b/.gitlab-ci.yml<br />@@ -64,6 +64,7 @@ default:<b=
r />- if [ "${release}" =3D "bookworm" ]; then base_yaml=3D"${base_yaml}:ka=
s/opt/bookworm.yml"; fi<br />- if [ "${release}" =3D "trixie" ]; then base_=
yaml=3D"${base_yaml}:kas/opt/trixie.yml"; fi<br />- if [ "${release}" =3D "=
sid" ]; then base_yaml=3D"${base_yaml}:kas/opt/sid.yml"; fi<br />+ - if [ "=
${release}" =3D "forky" ]; then base_yaml=3D"${base_yaml}:kas/opt/forky.yml=
"; fi</blockquote>
ordering</blockquote>
Thanks, I'll fix it.&nbsp;<br />
<blockquote>
<blockquote>- if [ "${encrypt}" =3D "enable" ]; then base_yaml=3D"${base_ya=
ml}:kas/opt/encrypt-data.yml"; fi<br />- if [ "${factory_reset}" =3D "enabl=
e" ]; then base_yaml=3D"${base_yaml}:kas/opt/factory-reset.yml"; fi<br />- =
if [ "${watchdog}" =3D "disable" ]; then base_yaml=3D"${base_yaml}:kas/opt/=
disable-watchdog.yml"; fi<br />@@ -399,6 +400,57 @@ build:qemu-arm-base-sid=
:<br />separate_home_partition: enable<br />deploy: enable<br /><br />+# fo=
rky image builds<br />+.build_base_forky:<br />+ extends:<br />+ - .build_b=
ase<br />+ rules:<br />+ - if: $CI_COMMIT_TAG<br />+ when: never<br />+ - i=
f: '$CI_PIPELINE_SOURCE =3D=3D "schedule" &amp;&amp; $CI_RUN_UNSTABLE_FORKY=
'</blockquote>
We should handle forky and sid identical for now, thus should likely use<br=
 />generic CI_RUN_UNSTABLE for both. Forky can then be moved out of this<br=
 />mode somewhere next year and become another regular test target in the<b=
r />pipeline, sid will always remain there.</blockquote>
</div>
<div>&nbsp;</div>
<div>Sure, will change it to CI_RUN_UNSTABLE for both forky &amp; sid.&nbsp=
;</div>
<div><br />
<blockquote>
<blockquote>+ - if: $CI_COMMIT_BRANCH !=3D "master"<br />+ when: never<br /=
>+ allow_failure: true<br />+<br />+build:qemu-amd64-base-forky:<br />+ ext=
ends:<br />+ - .build_base_forky<br />+ variables:<br />+ target: qemu-amd6=
4<br />+ use_rt: disable<br />+ release: forky<br />+ extension: security<b=
r />+ security_test: enable<br />+ build_updates: enable<br />+ separate_ho=
me_partition: enable<br />+ deploy: enable<br />+<br />+build:qemu-arm64-ba=
se-forky:<br />+ extends:<br />+ - .build_base_forky<br />+ variables:<br /=
>+ target: qemu-arm64<br />+ use_rt: disable<br />+ release: forky<br />+ e=
xtension: security<br />+ security_test: enable<br />+ build_updates: enabl=
e<br />+ separate_home_partition: enable<br />+ deploy: enable<br />+<br />=
+build:qemu-arm-base-forky:<br />+ extends:<br />+ - .build_base_forky<br /=
>+ variables:<br />+ target: qemu-arm<br />+ extension: security<br />+ sec=
urity_test: enable<br />+ use_rt: disable<br />+ release: forky<br />+ buil=
d_updates: enable<br />+ separate_home_partition: enable<br />+ deploy: ena=
ble<br />+<br />.test-cip-core:<br />stage: test<br />image: $CI_REGISTRY_I=
MAGE/lavacli<br />@@ -764,6 +816,47 @@ test:qemu-arm-IEC-sid:<br />test_fun=
ction: IEC<br />iec_test_timeout: 40<br /><br />+# Tests for forky images<b=
r />+.test-cip-core-forky:<br />+ extends:<br />+ - .test-cip-core<br />+ r=
ules:<br />+ - if: $CI_COMMIT_TAG<br />+ when: never<br />+ - if: '$CI_PIPE=
LINE_SOURCE =3D=3D "schedule" &amp;&amp; $CI_RUN_UNSTABLE_FORKY'<br />+ - i=
f: $CI_COMMIT_BRANCH !=3D "master"<br />+ when: never<br />+ allow_failure:=
 true<br />+<br />+test:qemu-amd64-IEC-forky:<br />+ extends:<br />+ - .tes=
t-cip-core-forky<br />+ variables:<br />+ target: qemu-amd64<br />+ release=
: forky<br />+ test_function: IEC<br />+ iec_test_timeout: 40<br />+<br />+=
test:qemu-arm64-IEC-forky:<br />+ extends:<br />+ - .test-cip-core-forky<br=
 />+ needs: ["build:qemu-arm64-base-forky"]<br />+ variables:<br />+ target=
: qemu-arm64<br />+ release: forky<br />+ test_function: IEC<br />+ iec_tes=
t_timeout: 40<br />+<br />+test:qemu-arm-IEC-forky:<br />+ extends:<br />+ =
- .test-cip-core-forky<br />+ needs: ["build:qemu-arm-base-forky"]<br />+ v=
ariables:<br />+ target: qemu-arm<br />+ release: forky<br />+ test_functio=
n: IEC<br />+ iec_test_timeout: 40<br />+<br />cve-checks:<br />stage: cve-=
check<br />needs: []</blockquote>
I'm still wondering what the added value of testing sid for us is. I<br />w=
ould rather consider to invest our CI time into running more tests with<br =
/>forky, like some more SWUpdate checks and/or reproducibility.</blockquote=
>
</div>
<div>Understood, we can add more tests like SWUpdate, secure boot and RB bu=
ilds for forky. I will include them in v2 patch.</div>
<div>&nbsp;</div>
<div>considering the value of testing for sid,&nbsp;</div>
<div>- The latest updates/fixes to any package will appear in sid before fo=
rky.&nbsp;As a community we can test early and report issues and also contr=
ibute to Debian to fix the issues if required.</div>
<div>&nbsp;</div>
<div>please note we have only minimal tests for sid now and also running it=
 weekly. if required we can still remove the sid testing from CI, kindly le=
t me know.&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks &amp; Regards</div>
<div>Shivanand K</div>

--MwjK7mcTqjK8p3dRhb3F--

