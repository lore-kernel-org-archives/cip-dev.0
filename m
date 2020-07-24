Return-Path: <SRS0=XxHb=BD=lists.cip-project.org=bounce+64572+5010+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8861DC433DF
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 17:07:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4DB206D8
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 17:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mUUH4oq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4DB206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5010+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ooxzYY4521723xh2tyoOVZvR; Fri, 24 Jul 2020 10:07:34 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.293.1595610452133231703
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 10:07:33 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 06OH7AVU029510
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2020 19:07:10 +0200
X-Received: from [139.22.112.247] ([139.22.112.247])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06OH76bs007058;
	Fri, 24 Jul 2020 19:07:07 +0200
Subject: Re: [cip-dev] [PATCH 4.9 18/22] x86/fpu: Disable bottom halves while loading FPU registers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, kvm ML <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>,
        Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>,
        cip-dev <cip-dev@lists.cip-project.org>
References: <20181228113126.144310132@linuxfoundation.org>
 <20181228113127.414176417@linuxfoundation.org>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <01857944-ce1a-c6cd-3666-1e9b6ca8cccc@siemens.com>
Date: Fri, 24 Jul 2020 19:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20181228113127.414176417@linuxfoundation.org>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 06OH7AVU029510
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KIckXhV9V3M4If7FepqcWrxNx4520388AA=
Content-Type: multipart/mixed; boundary="qOnjBIBJAvjte8waj7OO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595610454;
 bh=N7sMpaVvV8ZA+uOSKFku4BmC3J5QHuPBsLllQTaI3c0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mUUH4oq84KvlEtRDuZfPGMXa/xdFuGrSOdVyO9ZnY60gWUt5MOR7/YhN9QrxsIbBAoV
 0yANh90CpjfXaoEyeaOVd3GMDpzlIg8BdLGIqwztT2cp4vyW4xoS8laoGabCOOJgijjhW
 XSiAOb1zVTAm30pzs9cFu+2bUA6pBDyHd/E=

--qOnjBIBJAvjte8waj7OO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.12.18 12:52, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me k=
now.
>=20
> ------------------
>=20
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> commit 68239654acafe6aad5a3c1dc7237e60accfebc03 upstream.
>=20
> The sequence
>=20
>    fpu->initialized =3D 1;		/* step A */
>    preempt_disable();		/* step B */
>    fpu__restore(fpu);
>    preempt_enable();
>=20
> in __fpu__restore_sig() is racy in regard to a context switch.
>=20
> For 32bit frames, __fpu__restore_sig() prepares the FPU state within
> fpu->state. To ensure that a context switch (switch_fpu_prepare() in
> particular) does not modify fpu->state it uses fpu__drop() which sets
> fpu->initialized to 0.
>=20
> After fpu->initialized is cleared, the CPU's FPU state is not saved
> to fpu->state during a context switch. The new state is loaded via
> fpu__restore(). It gets loaded into fpu->state from userland and
> ensured it is sane. fpu->initialized is then set to 1 in order to avoid
> fpu__initialize() doing anything (overwrite the new state) which is par=
t
> of fpu__restore().
>=20
> A context switch between step A and B above would save CPU's current FP=
U
> registers to fpu->state and overwrite the newly prepared state. This
> looks like a tiny race window but the Kernel Test Robot reported this
> back in 2016 while we had lazy FPU support. Borislav Petkov made the
> link between that report and another patch that has been posted. Since
> the removal of the lazy FPU support, this race goes unnoticed because
> the warning has been removed.
>=20
> Disable bottom halves around the restore sequence to avoid the race. BH
> need to be disabled because BH is allowed to run (even with preemption
> disabled) and might invoke kernel_fpu_begin() by doing IPsec.
>=20
>   [ bp: massage commit message a bit. ]
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: kvm ML <kvm@vger.kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: stable@vger.kernel.org
> Cc: x86-ml <x86@kernel.org>
> Link: http://lkml.kernel.org/r/20181120102635.ddv3fvavxajjlfqk@linutron=
ix.de
> Link: https://lkml.kernel.org/r/20160226074940.GA28911@pd.tnic
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   arch/x86/kernel/fpu/signal.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -342,10 +342,10 @@ static int __fpu__restore_sig(void __use
>   			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
>   		}
>  =20
> +		local_bh_disable();
>   		fpu->fpstate_active =3D 1;
> -		preempt_disable();
>   		fpu__restore(fpu);
> -		preempt_enable();
> +		local_bh_enable();
>  =20
>   		return err;
>   	} else {
>=20
>=20

Any reason why the backport stopped back than at 4.9? I just debugged=20
this out of a 4.4 kernel, and it is needed there as well. I'm happy to=20
propose a backport, would just appreciate a hint if the BH protection is=20
needed also there (my case was without BH).

Thanks,
Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--qOnjBIBJAvjte8waj7OO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5010): https://lists.cip-project.org/g/cip-dev/message=
/5010
Mute This Topic: https://lists.cip-project.org/mt/75770466/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qOnjBIBJAvjte8waj7OO--
