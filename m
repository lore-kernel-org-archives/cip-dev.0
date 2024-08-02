Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49298C52D6F
	for <webhook@archiver.kernel.org>; Fri,  2 Aug 2024 11:31:33 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by mx.groups.io with SMTP id smtpd.web11.90232.1722596569959994248
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Aug 2024 04:02:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=jan.kiszka@web.de header.s=s29768273 header.b=oLI6SLjz;
 spf=pass (domain: web.de, ip: 212.227.15.4, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722596567; x=1723201367; i=jan.kiszka@web.de;
	bh=mR9pwmu3/4h0k1BuY9dHHzv9AuyUOGiFx1ZVfONoJBM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oLI6SLjzSvXelyPCPo5/HIkv0YDEGKxdQ4SpYEMeVjxDVJhwH5ubkrdv8IfBxXze
	 WLFuPiodtBYUBYyT9giwgaf9Ib2/GZlbKDDwqxjdrRSwIzgXlbPm+VhZjvA7t6G2B
	 /IXnFROkIpes/NVfttJYDp9k7UqF08kv4DODATPAEPtDm6lMstTv3wleTTgXBKehv
	 a+oEEiJ9IVNPSQvq0pD8umirXVJLAy48WIqR5at9u1GxQ0gC9sObOyfTVZd8b2j5G
	 Czyyyo0aET1AgRenHj87rRRqDdAOYJ9osDWHbe2LkTa0J7DJPTQiorCYdkVSH0kVI
	 ZjgOCVOhZAg7QUozTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.168.54]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB49-1snKZb3bvd-00TCgn; Fri, 02
 Aug 2024 13:02:47 +0200
Message-ID: <904fd42c-374f-4e84-92dd-8e5576ec5237@web.de>
Date: Fri, 2 Aug 2024 13:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] submit_lava.sh: Modify environment slug in SQUAD
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240802062317.3333603-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CwZcEEwEKAEECGwMFCQWjmoAFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQQATGR9dXLPfXK9tPtpnYUKn0F72AUCZlj8RgIZAQAKCRBpnYUKn0F72EwQ
 D/49OlL8Dg8zPSSEC35eXcKZH7+bi19kNbWztr/dr9XO6YBGXhfgBNn8HqnlbSu+1ApyVjhL
 0oL28uFvfIzLj3/qkbPCuPJ2MSOvtVYVlsBhp4lUWo4LmwlYEqhXmVrpYxPnNdJPsiyl9aaU
 mDzdr3sRnJNdUWZfmXp80FbC0hBiOcKhx+lprMEIjN4UEQtOtKc4SG4wdg/1VEalhoIcKmUN
 +p0GBCEYp3KDy2RoyhhhHdxoL3CLbgcKavDrYrgPsFGa8KlH/UIwk9s9PHa9i+JExkTynqqE
 PhDQJq7zY3hhG2vYXmE9M5H3/vveUFQQIxM5j20Y7YzpVYDoMpcdu8MuIIIAaisIYKkSHps3
 /dDScjBdLu9g0V2yIecXGvbYaeTHM/A0NguL+sW4xTTR/9vj64u+0EhC5bF8PNEUWXvHIDNC
 XcnmDn3VEvM39juimpOEdNGOcunA9evFbDJznVEBmK2qEHfdfZr09dCpltxzLXZI101pFgEq
 MBCPR381u2e6dhXY7obm0Ke+RkL6/qDrqDP2BzJrThAiZGe4MgbmlG0hN/eh2iUlQDxidDgj
 5/xA30OP7vGMIK0iHDsLhxDEc4BdW0WXHOO/eBHTMGfu6YiKOf6MeO7xicuFv3kYrS2opv1r
 1wYPoUzNO1lgHzKxdPyHuPL4IylNrRXFWSBxO87BTQRmWPoZARAA2+arluDNHmljyI6mOmgv
 7xwpqRC5kvxzGuc5QNHVpcQjxI5HITfFuDwfjTDlxRCbiiyxbOvrOfypTaJP5BioOHyE31XH
 fgUHf2EZLN6hYn3JFPpMaF6U3Nm5LE7S7oj5HMhZowaYfwRprN+ZrzgNDmhDun0G2roh2kJ2
 K4FEDPmA+LhaEDi51kz5gY3HKD7oiQ2n8y8cI+K/iR+HwP+M8w2uThW31at4nmBqoga7Y7QR
 b+XqVbxitc6EPkXPoefnQlj8Atot3F01FX9MKHqRfJlFxXDYWPhIfL74dZcXw9+c9giXmLcT
 HAOOC6dOpAK6Vg4xiXXXfjk5lJBVnmLQHWgqY/xiLbiXEGZGmk3oh6jz6271zN+ta7b2sFxV
 M1Jb6FtUm+/0nhPwbVqMZHmToLKqLlz045RS2qby7uYPTDzYpo5GKrpAEqv/nvDDCj/hBL9w
 QBVRRrzRN1JTUYfqaQagVGYqpM4OKtoX3k454r4Aoc15b308fTOgSZrg52AIaOAQOr0YeA6+
 y2EyyMBo4LiLrkHD9hDTfpd9p4ncteeMwhKef0b+CvEmHVXoK0O61olC4A8/VUFqNswI6E4B
 SoNwBN7ow8uFdlZ3bZDEWKcMLopQg0PgaW+YsX2xcmeKFRrOhd44bVjeVLuNxYR0gqlL/BQs
 5eOAMhrpVWFO4U0AEQEAAcLBfAQYAQoAJhYhBABMZH11cs99cr20+2mdhQqfQXvYBQJmWPoZ
 AhsMBQkFo5qAAAoJEGmdhQqfQXvYTd4P/AnTapTnwWRghTWfCn+LaUaXjd0xpnpBkaaIVGwT
 Lx2IllvEr5goBLgaJEvi8d6cjyUAmGQ1ywquO4LC3Z4VXENmSjQq6/coa4+pB8XtUqr9UjIc
 Q/HQalughXv5m4ivcBDAyKsrOy9F8v5YAhcWbMJQVt3lNmWnHaNHw8y4iZvSNAvYj2c5CYCE
 46KrIiIv+XN3gmNrNjhDS/VT14h9Rj0Hx2dt6LojH/qI1We5MnC48/pxa+QNeMPwe7h487i+
 rZwPgLRgq3nQ53uui0itxw9Lwu+evbGf4/JBio5VLQvs5tI9N4jyOoIvGHgp/W+BfLC6QZQX
 ZaqPQQfrqqDOhfMzHyHw7KowdK/6u1niWiPDSnxcDThj7qPdzfllMgYtsmAlzDoAVIn5tE+h
 2390h0KWwOesHCj1iagAtohWsTQ6MHCYo/S7RKjpU6AjLQwXpA8HIUb6q1jdZg1y4Pmr/Kh+
 JA87Kil/M8083wFhca5FwP5BaUdybDMzZr3sbZDdpDiwgh5MptM8+WN78WmLW1xtsE66ifFq
 ZFiBPEk1IUGvQJHs4LnFze6+rkq81vCEF8QSJ2cBSMgYDNH/388jas04RU9eUDK2FKoYVmX3
 zuD3jSTlGH13R9dwOq21NMusROzpLqGtNRKjYvcqsiwPID4IPw4TqRrSvCqJArHWLE25
In-Reply-To: <20240802062317.3333603-1-Sai.Sathujoda@toshiba-tsip.com>
X-Provags-ID: V03:K1:+RDqhpj530Ep55UwiQ9s/orlczP25Cu1WcsG6v9vkmDFWUWJblO
 kMn1SgX5jWdvWHi5XC23bW4UYhnFtQ5YsYxc6oA8RM7hM5bbALjEoosUTgv5mOQNyrv3LMr
 V2ZkVX0N6kzcwyPJS1GbrU/TanMVlCnulKZPbB29cwqw05uFhhhF3OD6QUpusJRSNGuyi6m
 xzcIgXC66y6aitW1RQ5gg==
UI-OutboundReport: notjunk:1;M01:P0:/ePLOcQkeKo=;coC5Fm5jCrjtznM9rEMxtwFRAM2
 HgygQbxV6FO1zNwRfk5YO1ijma/4hyy3fRwq8sqmU+gxxz8ql1HQwXkklMEyNLwxoHULG7LC7
 2sKlGdoFJuGBA110FUwqrk6t4zcLvSutiV3LdVVyTjHN5fH2N2cp9dwUEgT+Q6/wl0mIV56d1
 AtOkU0ElDylrMrftTyKkUbbGGeK2E3ExIc66PpiakHqXVIDWryY4osm33D3TuPSLHsZ9ZKQr7
 GE7E+UnwmOvXh4Juoh9wv41IQMMdsQfzQa/TOVQKvM+3DtKHC7A3kz3cOv6F7r8vwhLdpbhyM
 2JQvUvxJmYEYx6T86rXh0u/CE/CC5ufx5RHIY5Wn+UdorPGpsTncPZRXWbXY15n5y2M/ehWjj
 c3pNqfRX+7tI5EW/jwLb61BgOFaoh7JfpnBSFV7Sj0uGru3k374P1yVvLi2cIOHJ7nJQSWgoM
 XLtlKwSPJQDuuZEFw5VB0ZWnqXqwxZyelUsYAhS7z2fIoZevpDyxZwmoGbE7yfY7LWSaiwFLF
 p+OVcJQZ5tNt203k1Ag4cIBoLAVdZiTi/q4NIX+sIuXNnyNPaus+8jNmRkq1Z63SOtE5oe/BA
 SbppCkJMiCh8Ru93xhuzlR4TFJXpBTyBf/OqLcmHGEeBAEG61vuvAfvVof0qhVrt7W3c41I9m
 qtC2HUOUXwZ/O4guIIqjfUQXEUthTy20dmgRscnjUHAqLG30YhnfqqA5d3N0TqTgLybcScbMu
 Apx3v4l80WU5Nb3OyIovQzCt26T1pzzqFko8Yo9PaEV4M8N5G6Olo1I85to4KZXfhD3PRd5Rs
 YyUiYP5MChyT15/LGPcyQT7g==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Aug 2024 11:31:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16709

On 02.08.24 08:23, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>
> This commit modifies environment slug for test results hosted in SQUAD.
> Currently the slug includes device name which keeps varying as that depe=
nds
> on assigned device in LAVA Lab. Ex: "qemu-cip-siemens-muc", "qemu-renesa=
s-01"
> etc.
>
> Environment slug should denote the test suite as well as the target on w=
hich
> tests are executed. So it needs target information as part of it instead=
 of
> device allocated. This also helps in fetching the results from SQUAD usi=
ng
> squad-client while generating test reports.
>
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  scripts/submit_lava.sh | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index b9015f3..1f55c3b 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -104,19 +104,18 @@ submit_squad_watch_job(){
>  	fi
>
>  	if [ "$TEST" =3D "swupdate" ] || [ "$TEST" =3D "kernel-panic" ] || [ "=
$TEST" =3D "initramfs-crash" ]; then
> -		squad_project=3D"swupdate-testing"
> +		SQUAD_PROJECT=3D"swupdate-testing"
>  	elif [ "$TEST" =3D "secure-boot" ]; then
> -		squad_project=3D"secure-boot-testing"
> +		SQUAD_PROJECT=3D"secure-boot-testing"
>  	elif [ "$TEST" =3D "IEC" ]; then
> -		squad_project=3D"iec-layer-testing"
> +		SQUAD_PROJECT=3D"iec-layer-testing"
>  	else
>  		echo "Unable to host results in available CIP Core SQUAD projects"
>  		return 1
>  	fi
>
> -	local DEVICE=3D$2
> -	local ENV=3D"${DEVICE}_${squad_project}"
> -	local squad_url=3D"$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${squad_projec=
t}/${COMMIT_REF}/${ENV}"
> +	local ENV=3D"${SQUAD_PROJECT}_${TARGET}"
> +	local squad_url=3D"$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${SQUAD_PROJEC=
T}/${COMMIT_REF}/${ENV}"
>  	ret=3D$(curl -s \
>  		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
>  		--form backend=3D"$SQUAD_LAVA_BACKEND" \
> @@ -165,7 +164,7 @@ submit_job() {
>  				| cut -d ":" -f 2 \
>  				| awk '{$1=3D$1};1')
>
> -			submit_squad_watch_job "${ret}" "${DEVICE}"
> +			submit_squad_watch_job "${ret}"
>
>  			lavacli $LAVACLI_ARGS jobs logs "${ret}"
>  			lavacli $LAVACLI_ARGS results "${ret}"

Thanks, applied.

Jan


