Return-Path: <SRS0=yiUP=BD=lists.cip-project.org=bounce+64572+5012+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B9FC433E1
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 18:12:20 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4895B20759
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 18:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nwl9sbXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4895B20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5012+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Vg5pYY4521723xmrxDewm0jj; Fri, 24 Jul 2020 11:12:20 -0700
X-Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mx.groups.io with SMTP id smtpd.web11.1698.1595614324494423113
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 11:12:04 -0700
X-Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AC1BC20674;
	Fri, 24 Jul 2020 18:12:03 +0000 (UTC)
Date: Fri, 24 Jul 2020 14:12:02 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	kvm ML <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.9 18/22] x86/fpu: Disable bottom halves while loading FPU registers
Message-ID: <20200724181202.GG406581@sasha-vm>
References: <20181228113126.144310132@linuxfoundation.org>
 <20181228113127.414176417@linuxfoundation.org>
 <01857944-ce1a-c6cd-3666-1e9b6ca8cccc@siemens.com>
 <20200724174437.GB555114@kroah.com>
MIME-Version: 1.0
In-Reply-To: <20200724174437.GB555114@kroah.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xqtg0IDaqebcZruyCH1orGn0x4520388AA=
Content-Type: multipart/mixed; boundary="DNRs5HN2JGVkOXwHrHSU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595614340;
 bh=FdUNtZXvptT8CZL8d58suaE6uJIY34sa1euKWmR1lPk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nwl9sbXGqGXkiVaOWJuw8T+qHqquGckvkKIUgWSSWq8RdNVcU2YEQv66H6wO30scr/E
 RV3dYS84I5+oQrt/3CGWP9wwLeLCs/ibNh6Kj+iW83ly/go66T/8rjIFlovfdzI621C1T
 YS+Iuxn70/6JXERkZdQVCREG/CnMdQq8/AQ=

--DNRs5HN2JGVkOXwHrHSU
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 07:44:37PM +0200, Greg Kroah-Hartman wrote:
>On Fri, Jul 24, 2020 at 07:07:06PM +0200, Jan Kiszka wrote:
>> On 28.12.18 12:52, Greg Kroah-Hartman wrote:
>> > 4.9-stable review patch.  If anyone has any objections, please let m=
e know.
>> >
>> > ------------------
>> >
>> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> >
>> > commit 68239654acafe6aad5a3c1dc7237e60accfebc03 upstream.
>> >
>> > The sequence
>> >
>> >    fpu->initialized =3D 1;		/* step A */
>> >    preempt_disable();		/* step B */
>> >    fpu__restore(fpu);
>> >    preempt_enable();
>> >
>> > in __fpu__restore_sig() is racy in regard to a context switch.
>> >
>> > For 32bit frames, __fpu__restore_sig() prepares the FPU state within
>> > fpu->state. To ensure that a context switch (switch_fpu_prepare() in
>> > particular) does not modify fpu->state it uses fpu__drop() which set=
s
>> > fpu->initialized to 0.
>> >
>> > After fpu->initialized is cleared, the CPU's FPU state is not saved
>> > to fpu->state during a context switch. The new state is loaded via
>> > fpu__restore(). It gets loaded into fpu->state from userland and
>> > ensured it is sane. fpu->initialized is then set to 1 in order to av=
oid
>> > fpu__initialize() doing anything (overwrite the new state) which is =
part
>> > of fpu__restore().
>> >
>> > A context switch between step A and B above would save CPU's current=
 FPU
>> > registers to fpu->state and overwrite the newly prepared state. This
>> > looks like a tiny race window but the Kernel Test Robot reported thi=
s
>> > back in 2016 while we had lazy FPU support. Borislav Petkov made the
>> > link between that report and another patch that has been posted. Sin=
ce
>> > the removal of the lazy FPU support, this race goes unnoticed becaus=
e
>> > the warning has been removed.
>> >
>> > Disable bottom halves around the restore sequence to avoid the race.=
 BH
>> > need to be disabled because BH is allowed to run (even with preempti=
on
>> > disabled) and might invoke kernel_fpu_begin() by doing IPsec.
>> >
>> >   [ bp: massage commit message a bit. ]
>> >
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> > Signed-off-by: Borislav Petkov <bp@suse.de>
>> > Acked-by: Ingo Molnar <mingo@kernel.org>
>> > Acked-by: Thomas Gleixner <tglx@linutronix.de>
>> > Cc: Andy Lutomirski <luto@kernel.org>
>> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> > Cc: "H. Peter Anvin" <hpa@zytor.com>
>> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
>> > Cc: kvm ML <kvm@vger.kernel.org>
>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> > Cc: Rik van Riel <riel@surriel.com>
>> > Cc: stable@vger.kernel.org
>> > Cc: x86-ml <x86@kernel.org>
>> > Link: http://lkml.kernel.org/r/20181120102635.ddv3fvavxajjlfqk@linut=
ronix.de
>> > Link: https://lkml.kernel.org/r/20160226074940.GA28911@pd.tnic
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> >   arch/x86/kernel/fpu/signal.c |    4 ++--
>> >   1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > --- a/arch/x86/kernel/fpu/signal.c
>> > +++ b/arch/x86/kernel/fpu/signal.c
>> > @@ -342,10 +342,10 @@ static int __fpu__restore_sig(void __use
>> >   			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
>> >   		}
>> > +		local_bh_disable();
>> >   		fpu->fpstate_active =3D 1;
>> > -		preempt_disable();
>> >   		fpu__restore(fpu);
>> > -		preempt_enable();
>> > +		local_bh_enable();
>> >   		return err;
>> >   	} else {
>> >
>> >
>>
>> Any reason why the backport stopped back than at 4.9? I just debugged =
this
>> out of a 4.4 kernel, and it is needed there as well. I'm happy to prop=
ose a
>> backport, would just appreciate a hint if the BH protection is needed =
also
>> there (my case was without BH).
>
>You are asking about something we did back in 2018.  I can't remember
>what I did last week :)
>
>If you provide a backport that works, I'll be glad to take it.  The
>current patch does not apply cleanly there at all.

The conflict was due to a missing rename back in 4.4: e4a81bfcaae1
("x86/fpu: Rename fpu::fpstate_active to fpu::initialized").

I've fixed up the patch and queued it for 4.4, thanks for pointing it
out Jan!

--=20
Thanks,
Sasha

--DNRs5HN2JGVkOXwHrHSU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5012): https://lists.cip-project.org/g/cip-dev/message=
/5012
Mute This Topic: https://lists.cip-project.org/mt/75770466/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DNRs5HN2JGVkOXwHrHSU--
