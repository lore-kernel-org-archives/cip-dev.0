Return-Path: <d.kauschke154@googlemail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C7CD6ACE2
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 14:48:00 +0000 (UTC)
Subject: Re: Hardware Support for Raspberry Pi 4
To: cip-dev@lists.cip-project.org
From: d.kauschke154@googlemail.com
X-Originating-Location: Munich, Bavaria, DE (188.195.227.82)
X-Originating-Platform: Linux Firefox 131
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 06:47:55 -0800
References: <bf09c286-2b4d-4c39-b0bc-0880215d7c7d@siemens.com>
In-Reply-To: <bf09c286-2b4d-4c39-b0bc-0880215d7c7d@siemens.com>
Message-ID: <2202.1732718875254901355@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="4adsyVKmMMGFvV51qcS6"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 14:48:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17294

--4adsyVKmMMGFvV51qcS6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan, hi Quirin,

thank you for your detailed informations about the current state for the Ra=
spi4.
It sounds like a good starting point to build upon.

On Wed, Nov 27, 2024 at 07:48 AM, Quirin Gylstorff wrote:

>=20
> Hi David,
>=20
> On 11/27/24 06:28, Jan Kiszka wrote:
>=20
>> Hi David,
>>=20
>> On 25.11.24 16:00, d.kauschke154@googlemail.com wrote:
>>=20
>>> Hello everyone,
>>>=20
>>> I am interested in understanding the current state of hardware support
>>> for the Raspberry Pi 4 within the cip project.
>>> My goal is to use the Raspberry Pi 4 with secure boot and secure update
>>> mechanisms based on the cip project.
>>>=20
>>> 1)) What progress has been made so far in supporting the Raspberry Pi 4
>>> hardware in the cip project?
>>> 2)) How can any remaining gaps or challenges be addressed to achieve
>>> full support?
>>=20
>> IIRC, Quirin once had a prototype for that, just not public. He may
>> answer best what was need or what would still be missing.
>=20
> For our internal rpi4 prototype we used the following boot chain:
>=20
> raspi firmware -> U-Boot -> efibootguard -> CIP kernel -> A/B
>=20
> I added the following adaptations:
> - Raspi-config for booting U-boot
> - U-boot config for Raspi4 with EFI support
> - Additional bcm2711_defconfig for CIP kernel(6.1.y-cip)
> - wks for RPI4 and A/B rootfs

>=20
> The rest of the cip stack should then work out of the box.
>=20
> Quirin

Would it be possible to share the Raspi4 prototype publicly? I think having=
 access to it would not only help me but also encourage others in the commu=
nity to contribute
and improve on the work you've started.

>=20
>=20
>>=20
>>> 3)) What steps or contributions would be most valuable in advancing thi=
s
>>> effort?
>>=20
>> Baseline would be a booting image with a compatible CIP kernel. From
>> there, we would need to see what is missing for SWUpdate and Secure Boot
>> (both via UEFI). Probably just the integration of a chain-loaded recent
>> U-Boot as UEFI provider.
>>=20
>> But note that no CIP member has so far expressed demand for officially
>> supporting that hardware and its SoC. So you may have to bring an
>> RPi-specific recipe rule to add potentially disabled (and not officially
>> supported) kernel features via a config snippet.
>>=20
>> Jan
>=20
>=20

Therefore CIP support for the Raspi4 platform is not planned in the medium =
term (next 1-2 years) , correct?
So a possible starting approach could be to create a public meta-cip-raspbe=
rrypi4 on Github like the project https://github.com/siemens/meta-iot2050 ?

David

--4adsyVKmMMGFvV51qcS6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>Hi Jan, hi Quirin,</div>
<div>&nbsp;</div>
<div>thank you for your detailed informations about the current state for t=
he Raspi4.</div>
<div>It sounds like a good starting point to build upon.</div>
</div>
<div>&nbsp;</div>
<div>On Wed, Nov 27, 2024 at 07:48 AM, Quirin Gylstorff wrote:</div>
<div>
<blockquote>Hi David,<br /><br />On 11/27/24 06:28, Jan Kiszka wrote:<br />
<blockquote>Hi David,<br /><br />On 25.11.24 16:00, d.kauschke154@googlemai=
l.com wrote:<br />
<blockquote>Hello everyone,<br /><br />I am interested in understanding the=
 current state of hardware support<br />for the Raspberry Pi 4 within the c=
ip project.<br />My goal is to use the Raspberry Pi 4 with secure boot and =
secure update<br />mechanisms based on the cip project.<br /><br />1)) What=
 progress has been made so far in supporting the Raspberry Pi 4<br />hardwa=
re in the cip project?<br />2)) How can any remaining gaps or challenges be=
 addressed to achieve<br />full support?</blockquote>
IIRC, Quirin once had a prototype for that, just not public. He may<br />an=
swer best what was need or what would still be missing.</blockquote>
For our internal rpi4 prototype we used the following boot chain:<br /><br =
/>raspi firmware -&gt; U-Boot -&gt; efibootguard -&gt; CIP kernel -&gt; A/B=
<br /><br />I added the following adaptations:<br />- Raspi-config for boot=
ing U-boot<br />- U-boot config for Raspi4 with EFI support<br />- Addition=
al bcm2711_defconfig for CIP kernel(6.1.y-cip)<br />- wks for RPI4 and A/B =
rootfs</blockquote>
</div>
<div>
<blockquote>The rest of the cip stack should then work out of the box.<br /=
><br />Quirin</blockquote>
</div>
<div>&nbsp;</div>
<div>Would it be possible to share the Raspi4 prototype publicly? I think h=
aving access to it would not only help me but also encourage others in the =
community to contribute</div>
<div>and improve on the work you've started.</div>
<div>&nbsp;</div>
<div><br />
<blockquote>
<blockquote>
<blockquote>3)) What steps or contributions would be most valuable in advan=
cing this<br />effort?</blockquote>
Baseline would be a booting image with a compatible CIP kernel. From<br />t=
here, we would need to see what is missing for SWUpdate and Secure Boot<br =
/>(both via UEFI). Probably just the integration of a chain-loaded recent<b=
r />U-Boot as UEFI provider.<br /><br />But note that no CIP member has so =
far expressed demand for officially<br />supporting that hardware and its S=
oC. So you may have to bring an<br />RPi-specific recipe rule to add potent=
ially disabled (and not officially<br />supported) kernel features via a co=
nfig snippet.<br /><br />Jan</blockquote>
</blockquote>
</div>
<div>Therefore CIP support for the Raspi4 platform is not planned in the me=
dium term (next 1-2 years) , correct?<br />So a possible starting approach =
could be to create a public meta-cip-raspberrypi4 on Github like the projec=
t <a href=3D"https://github.com/siemens/meta-iot2050" target=3D"_blank" rel=
=3D"noopener">https://github.com/siemens/meta-iot2050</a> ?<br /><br /></di=
v>
<div>David</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

--4adsyVKmMMGFvV51qcS6--

