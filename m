Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79244CFD376
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:45:09 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4389.1764668699952556926
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:45:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm2 header.b=px9nzdpP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-68982-202512020944564724ed11930002079d-hdb7z7@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202512020944564724ed11930002079d
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:44:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1MKJi9rzMWYzx7SPWYhv+WAl1fZLD3W7FyARyN4ZsZs=;
 b=px9nzdpPF4DgBB9WORM2U3R2F/Af+oVUj2jOkeOOxhBQmAU5PDlp2Os87KQ+2Izyx+tqYp
 ns/m/2lDCXwh/hiBG2m/kgcB74HeNimC1/N6ele1wT/ysJQrdHAk3HgoZUyf2EMuLkS96XtO
 WJj4KU0DHHo6jcJlVxA9UUySNiaPPV/0wTR1k2rLaku4+npBCfhCKe9paYNibpqNIMQg/D/I
 jFc9md2FrxTQl0P/bkl2xitxQvNz3IuU1a55r9MwMFDFZKg+PM27nxLivAizNMz7Di5iqpW8
 4Lqc1bElFYIOCQ4eEczJ2iczgb5JItoncjvCGJAvhKFHSgDLp/9b5Oig==;
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Dec 2025 10:44:55 +0100
Message-Id: <DENMUFCSL2V5.2123DGIVNH8FU@siemens.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 02/14] ci: Prepare for running
 non-bookworm secure boot tests
From: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
 <db363a65607faf0a2906abc2905fa24364b01496.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <db363a65607faf0a2906abc2905fa24364b01496.1764667279.git.jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:45:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20803

On Tue Dec 2, 2025 at 10:21 AM CET, Jan Kiszka via lists.cip-project.org wr=
ote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Do no hard-code the release which provides alternative keys for the
> mismatch test. This allows for testing trixie as well.
>
> While at it, consolidate over OVMF_CODE_4M.secboot.fd which is actually
> identical to OVMF_CODE_4M.snakeoil.fd and is used elsewhere already.
> Will allow to deploy less with the lava-worker container.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  scripts/submit_lava.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index ea733748..f7da99c3 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -178,8 +178,13 @@ create_job_qemu () {
>  	sed -i -e "s@#architecture#@${2}@g" -e "s@#imageargs#@${image_args[$2]}=
@g" "${job_dir}"/*.yml
> =20
>  	if [ "$1" =3D "secure-boot-mismatch-keys" ]; then
> -		sed -i "s@/usr/share/OVMF/OVMF_CODE_4M.secboot.fd@/root/keys/trixie-ov=
mf/OVMF_CODE_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
> -		sed -i "s@/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd@/root/keys/trixie-o=
vmf/OVMF_VARS_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
> +		if [ "${RELEASE}" =3D "trixie" ]; then
> +			KEYS_DISTRO=3Dbookworm
> +		else
> +			KEYS_DISTRO=3Dtrixie
> +		fi

Really? That looks flipped, no?

> +		sed -i "s@/usr/share/OVMF/OVMF_CODE_4M.secboot.fd@/root/keys/${KEYS_DI=
STRO}-ovmf/OVMF_CODE_4M.secboot.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.y=
ml"
> +		sed -i "s@/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd@/root/keys/${KEYS_D=
ISTRO}-ovmf/OVMF_VARS_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}=
.yml"
>  	fi
> =20
>  	# Target is recieved from gitlab job in form of qemu-"architecture"


