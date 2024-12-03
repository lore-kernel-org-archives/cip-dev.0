Return-Path: <d.kauschke154@googlemail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6CAE6C60E
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 06:56:32 +0000 (UTC)
Subject: Re: Hardware Support for Raspberry Pi 4
To: cip-dev@lists.cip-project.org
From: d.kauschke154@googlemail.com
X-Originating-Location: Planegg, Bavaria, DE (145.253.133.129)
X-Originating-Platform: Linux Firefox 131
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 02 Dec 2024 22:56:22 -0800
References: <d76564b5-777d-4dd3-920c-a8c903ba37ce@siemens.com>
In-Reply-To: <d76564b5-777d-4dd3-920c-a8c903ba37ce@siemens.com>
Message-ID: <10227.1733208982266769629@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="XOc6Em1a6Sh0awEnupi5"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Dec 2024 06:56:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17322

--XOc6Em1a6Sh0awEnupi5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 03:12 PM, Jan Kiszka wrote:

>=20
> On 27.11.24 22:47, d.kauschke154@googlemail.com wrote:
>=20
>> Hi Jan, hi Quirin,
>>=20
>> thank you for your detailed informations about the current state for the
>> Raspi4.
>> It sounds like a good starting point to build upon.
>>=20
>> On Wed, Nov 27, 2024 at 07:48 AM, Quirin Gylstorff wrote:
>>=20
>> Hi David,
>>=20
>> On 11/27/24 06:28, Jan Kiszka wrote:
>>=20
>> Hi David,
>>=20
>> On 25.11.24 16:00, d.kauschke154@googlemail.com wrote:
>>=20
>> Hello everyone,
>>=20
>> I am interested in understanding the current state of
>> hardware support
>> for the Raspberry Pi 4 within the cip project.
>> My goal is to use the Raspberry Pi 4 with secure boot and
>> secure update
>> mechanisms based on the cip project.
>>=20
>> 1)) What progress has been made so far in supporting the
>> Raspberry Pi 4
>> hardware in the cip project?
>> 2)) How can any remaining gaps or challenges be addressed to
>> achieve
>> full support?
>>=20
>> IIRC, Quirin once had a prototype for that, just not public. He may
>> answer best what was need or what would still be missing.
>>=20
>> For our internal rpi4 prototype we used the following boot chain:
>>=20
>> raspi firmware -> U-Boot -> efibootguard -> CIP kernel -> A/B
>>=20
>> I added the following adaptations:
>> - Raspi-config for booting U-boot
>> - U-boot config for Raspi4 with EFI support
>> - Additional bcm2711_defconfig for CIP kernel(6.1.y-cip)
>> - wks for RPI4 and A/B rootfs
>>=20
>> The rest of the cip stack should then work out of the box.
>>=20
>> Quirin
>>=20
>>=20
>> Would it be possible to share the Raspi4 prototype publicly? I think
>> having access to it would not only help me but also encourage others in
>> the community to contribute
>> and improve on the work you've started.
>>=20
>>=20
>> 3)) What steps or contributions would be most valuable in
>> advancing this
>> effort?
>>=20
>> Baseline would be a booting image with a compatible CIP kernel. From
>> there, we would need to see what is missing for SWUpdate and
>> Secure Boot
>> (both via UEFI). Probably just the integration of a chain-loaded
>> recent
>> U-Boot as UEFI provider.
>>=20
>> But note that no CIP member has so far expressed demand for
>> officially
>> supporting that hardware and its SoC. So you may have to bring an
>> RPi-specific recipe rule to add potentially disabled (and not
>> officially
>> supported) kernel features via a config snippet.
>>=20
>> Jan
>>=20
>> Therefore CIP support for the Raspi4 platform is not planned in the
>> medium term (next 1-2 years) , correct?
>> So a possible starting approach could be to create a public meta-cip-
>> raspberrypi4 on Github like the project https://github.com/siemens/meta-
>> iot2050 < https://github.com/siemens/meta-iot2050 > ?
>=20
> I personally don't see a blocker for providing the required changes also
> via isar-cip-core. It's just that we would not commit on that target to
> be officially tested and, thus, long-term supported.

I understand your point of view.
Is there already a way/process to provide platforms via isar-cip-core witho=
ut any
commitments regarding testing and LTS?

>=20
> We can discuss this in the next Technical Steering Committee meeting to
> see what other members think.

That would be great.

>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center

--XOc6Em1a6Sh0awEnupi5
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Fri, Nov 29, 2024 at 03:12 PM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 27.11.24 22:47, d.kauschke154@googlemail.com wrote:<br />
<blockquote>Hi Jan, hi Quirin,<br />&nbsp;<br />thank you for your detailed=
 informations about the current state for the<br />Raspi4.<br />It sounds l=
ike a good starting point to build upon.<br />&nbsp;<br />On Wed, Nov 27, 2=
024 at 07:48 AM, Quirin Gylstorff wrote:<br /><br />Hi David,<br /><br />On=
 11/27/24 06:28, Jan Kiszka wrote:<br /><br />Hi David,<br /><br />On 25.11=
.24 16:00, d.kauschke154@googlemail.com wrote:<br /><br />Hello everyone,<b=
r /><br />I am interested in understanding the current state of<br />hardwa=
re support<br />for the Raspberry Pi 4 within the cip project.<br />My goal=
 is to use the Raspberry Pi 4 with secure boot and<br />secure update<br />=
mechanisms based on the cip project.<br /><br />1)) What progress has been =
made so far in supporting the<br />Raspberry Pi 4<br />hardware in the cip =
project?<br />2)) How can any remaining gaps or challenges be addressed to<=
br />achieve<br />full support?<br /><br />IIRC, Quirin once had a prototyp=
e for that, just not public. He may<br />answer best what was need or what =
would still be missing.<br /><br />For our internal rpi4 prototype we used =
the following boot chain:<br /><br />raspi firmware -&gt; U-Boot -&gt; efib=
ootguard -&gt; CIP kernel -&gt; A/B<br /><br />I added the following adapta=
tions:<br />- Raspi-config for booting U-boot<br />- U-boot config for Rasp=
i4 with EFI support<br />- Additional bcm2711_defconfig for CIP kernel(6.1.=
y-cip)<br />- wks for RPI4 and A/B rootfs<br /><br />The rest of the cip st=
ack should then work out of the box.<br /><br />Quirin<br /><br />&nbsp;<br=
 />Would it be possible to share the Raspi4 prototype publicly? I think<br =
/>having access to it would not only help me but also encourage others in<b=
r />the community to contribute<br />and improve on the work you've started=
.<br />&nbsp;<br /><br />3)) What steps or contributions would be most valu=
able in<br />advancing this<br />effort?<br /><br />Baseline would be a boo=
ting image with a compatible CIP kernel. From<br />there, we would need to =
see what is missing for SWUpdate and<br />Secure Boot<br />(both via UEFI).=
 Probably just the integration of a chain-loaded<br />recent<br />U-Boot as=
 UEFI provider.<br /><br />But note that no CIP member has so far expressed=
 demand for<br />officially<br />supporting that hardware and its SoC. So y=
ou may have to bring an<br />RPi-specific recipe rule to add potentially di=
sabled (and not<br />officially<br />supported) kernel features via a confi=
g snippet.<br /><br />Jan<br /><br />Therefore CIP support for the Raspi4 p=
latform is not planned in the<br />medium term (next 1-2 years) , correct?<=
br />So a possible starting approach could be to create a public meta-cip-<=
br />raspberrypi4 on Github like the project <a href=3D"https://github.com/=
siemens/meta-" target=3D"_blank" rel=3D"noopener">https://github.com/siemen=
s/meta-</a><br />iot2050 &lt;<a href=3D"https://github.com/siemens/meta-iot=
2050" target=3D"_blank" rel=3D"noopener">https://github.com/siemens/meta-io=
t2050</a>&gt; ?</blockquote>
I personally don't see a blocker for providing the required changes also<br=
 />via isar-cip-core. It's just that we would not commit on that target to<=
br />be officially tested and, thus, long-term supported.</blockquote>
</div>
<div>I understand your point of view.</div>
<div>Is there already a way/process to provide platforms via isar-cip-core =
without any</div>
<div>commitments regarding testing and LTS?</div>
<div>&nbsp;</div>
<div><br />
<blockquote>We can discuss this in the next Technical Steering Committee me=
eting to<br />see what other members think.</blockquote>
</div>
<div>&nbsp;</div>
<div>That would be great.</div>
<div><br />
<blockquote>Jan<br /><br />-- <br />Siemens AG, Technology<br />Linux Exper=
t Center</blockquote>
</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

--XOc6Em1a6Sh0awEnupi5--

