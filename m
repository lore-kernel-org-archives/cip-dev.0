Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC927C982CC
	for <webhook@archiver.kernel.org>; Sat, 19 Sep 2026 11:13:37 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH] Fix file timestamps are not reproducible for EFI certificates
To: cip-dev@lists.cip-project.org
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
X-Originating-Location: Hyderabad, Telangana, IN (151.186.148.44)
X-Originating-Platform: Windows Chrome 152
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 19 Sep 2026 04:13:29 -0700
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com> <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com> <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com> <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
In-Reply-To: <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
Message-ID: <632265.1789816409100489299@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="tuA8KCqvxDWuLIpXVOE7"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 19 Sep 2026 11:13:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24246

--tuA8KCqvxDWuLIpXVOE7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 04:21 AM, Felix Moessbauer wrote:

>=20
> On Fri, 2026-09-18 at 13:01 +0200, Jan Kiszka wrote:
>=20
>> On 18.09.26 12:54, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>=20
>>> On Fri, 2026-09-18 at 14:20 +0530, Kunijadar Shivanand wrote:
>>>=20
>>>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>>=20
>>>> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_it=
ems/162
>>>>=20
>>>>=20
>>>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.c=
om>
>>>> ---
>>>> .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb | 8 +++++++-
>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git
>>>> a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.b=
b
>>>> b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.b=
b
>>>> index 263f794..6a5357d 100644
>>>> ---
>>>> a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.b=
b
>>>> +++
>>>> b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.b=
b
>>>> @@ -24,6 +24,12 @@ DPKG_ARCH =3D "all"
>>>>=20
>>>> do_prepare_build() {
>>>> deb_debianize
>>>> + if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>>>=20
>>> Good catch! Thanks for debugging this. Please just use
>>> DEBIAN_CHANGELOG_TIMESTAMP instead of the SDE. This variable is always
>>> available and aligns the timestamp of SB parts with the one from the
>>> changelog.
>>=20
>>=20
>=20
>=20

Thanks, sent v2 patch to use DEBIAN_CHANGELOG_TIMESTAMP instead of SDE.

>=20
>=20
>> And simpler code - even better.
>>=20
>> Thanks for debugging my bug! :)
>=20
>=20

Thanks, the v2 patch has a simpler code now, removed condition check.
The recipe is updated to use timestamp option by default.

>=20
> While thinking about it, I'm wondering if the timestamp actually has
> security relevance (e.g. for checking the freshness of the DB). I know
> that timestamps in general are pointless in this context, but I'm
> wondering why it can be set in the first place.
>=20
> The DEBIAN_CHANGELOG_TIMESTAMP usually is set to 1h after unix epoch
> (for technical reasons 0 cannot be used as this is "magic").
>=20
> If we need a proper timestamp here, we should provide a way to set the
> DEBIAN_CHANGELOG_TIMESTAMP just for that package (e.g. by introducing a
> variable).
>=20
> But still, the code should use DEBIAN_CHANGELOG_TIMESTAMP to align the
> changelog timestamp with the SB one.
>=20
> Felix

Thanks & Regards
Shivanand K

--tuA8KCqvxDWuLIpXVOE7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Fri, Sep 18, 2026 at 04:21 AM, Felix Moessbauer wrote:</div>
<div>
<blockquote>On Fri, 2026-09-18 at 13:01 +0200, Jan Kiszka wrote:<br />
<blockquote>On 18.09.26 12:54, Moessbauer, Felix (FT RPD CED OES-DE) wrote:=
<br />
<blockquote>On Fri, 2026-09-18 at 14:20 +0530, Kunijadar Shivanand wrote:<b=
r />
<blockquote>From: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.=
com&gt;<br /><br />Closes <a href=3D"https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/work_items/162" target=3D"_blank" rel=3D"noopener">https:=
//gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162</a><br /><=
br />Signed-off-by: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsi=
p.com&gt;<br />---<br />.../secure-boot-efi-certs/single-key-to-efi-certs_0=
.1.bb | 8 +++++++-<br />1 file changed, 7 insertions(+), 1 deletion(-)<br /=
><br />diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-ef=
i-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-c=
erts_0.1.bb<br />index 263f794..6a5357d 100644<br />--- a/recipes-devtools/=
secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb<br />+++ b/recipes-dev=
tools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb<br />@@ -24,6 +2=
4,12 @@ DPKG_ARCH =3D "all"<br /><br />do_prepare_build() {<br />deb_debian=
ize<br />+ if [ -n "${SOURCE_DATE_EPOCH}" ]; then</blockquote>
Good catch! Thanks for debugging this. Please just use<br />DEBIAN_CHANGELO=
G_TIMESTAMP instead of the SDE. This variable is always<br />available and =
aligns the timestamp of SB parts with the one from the<br />changelog.</blo=
ckquote>
</blockquote>
</blockquote>
</div>
<div>&nbsp;</div>
<div>Thanks, sent v2 patch to use DEBIAN_CHANGELOG_TIMESTAMP instead of SDE=
.</div>
<div><br />
<blockquote>
<blockquote>And simpler code - even better.<br /><br />Thanks for debugging=
 my bug! :)</blockquote>
</blockquote>
</div>
<div>&nbsp;</div>
<div>Thanks, the v2 patch has a simpler code now, removed condition check.&=
nbsp;</div>
<div>The recipe is updated to use timestamp option by default.</div>
<div>
<blockquote>While thinking about it, I'm wondering if the timestamp actuall=
y has<br />security relevance (e.g. for checking the freshness of the DB). =
I know<br />that timestamps in general are pointless in this context, but I=
'm<br />wondering why it can be set in the first place.<br /><br />The DEBI=
AN_CHANGELOG_TIMESTAMP usually is set to 1h after unix epoch<br />(for tech=
nical reasons 0 cannot be used as this is "magic").<br /><br />If we need a=
 proper timestamp here, we should provide a way to set the<br />DEBIAN_CHAN=
GELOG_TIMESTAMP just for that package (e.g. by introducing a<br />variable)=
.<br /><br />But still, the code should use DEBIAN_CHANGELOG_TIMESTAMP to a=
lign the<br />changelog timestamp with the SB one.<br /><br />Felix</blockq=
uote>
</div>
<div>Thanks &amp; Regards</div>
<div>Shivanand K</div>

--tuA8KCqvxDWuLIpXVOE7--

