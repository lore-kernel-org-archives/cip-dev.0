Return-Path: <SRS0=bsTF=LE=lists.cip-project.org=bounce+64572+6500+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EC0C47094
	for <cip-dev@archiver.kernel.org>; Thu, 10 Jun 2021 05:33:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A82C613E1
	for <cip-dev@archiver.kernel.org>; Thu, 10 Jun 2021 05:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A82C613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6500+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WrWkYY4521723xRc3urpVaGK; Wed, 09 Jun 2021 22:33:21 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.6074.1623303200894554379
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Jun 2021 22:33:21 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 15A5XHEn002569
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jun 2021 07:33:18 +0200
X-Received: from [167.87.77.77] ([167.87.77.77])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15A5XHbe019008;
	Thu, 10 Jun 2021 07:33:17 +0200
Subject: Re: [cip-dev] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809
To: cip-dev@lists.cip-project.org, Rainer Kloud <rainer.kloud@abwesend.de>
References: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
 <20210606191433.GA18130@amd>
 <trinity-17b11b5f-9805-4527-89fb-1f3a0103a164-1623043418611@3c-app-gmx-bap15>
 <458aad5e-5455-e290-5ee1-f5eb78fb5c5e@siemens.com>
 <trinity-b2d83de7-b7f2-4f74-802b-0b2c801ae463-1623061125004@3c-app-gmx-bap15>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <785d1d13-5d5b-fb7d-707d-52ccc04f2e28@siemens.com>
Date: Thu, 10 Jun 2021 07:33:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <trinity-b2d83de7-b7f2-4f74-802b-0b2c801ae463-1623061125004@3c-app-gmx-bap15>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 15A5XHEn002569
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: C0IkzMKApMpUgWBVBmlQOweLx4520388AA=
Content-Type: multipart/mixed; boundary="QbVUePiN7cHPFhNudgKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623303201;
 bh=Ci0WJ7mwCpcoZJnnSjURxFyP87gWuKh7vpjKFhCYPX4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LjfDz51RpiCHhZKAkshb4LMdpOYsLobA1BMMSksBxsueksZenGw8tiV33OoDiXcSmoV
 Q1NehTAMBgzWq1Rk6v3S8V74WgjWknnaZl6II6XsuIFhUV4tJE1P0fERFAx+sNlXvCVjU
 FBeuCYpSbWWviE6wCDkMDbyPNDdfUt1nN0E=

--QbVUePiN7cHPFhNudgKR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.06.21 12:18, Rainer Kloud wrote:
> Hi,
> =C2=A0
>>>> I notice you are using -rt kernel. Do you actually need realtime
>>>> features?
>>>
>>> Yes, I actually need the realtime feature. I have one task which
>>> needs to run periodically in realtime (triggered every 10ms by an
>>> external IRQ).
>>>
>>
>> Please don't forget to share your kernel config with us so that we can
>> make sure your use case is covered subsystem-wise in CIP. From Siemens
>> side, we still have room for improvements in this regard, even more on=
 -rt.
> =C2=A0
> Attached you can find my kernel config.=C2=A0
> =C2=A0

Would you propose it as patch to
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config?

>>> Jun 1 09:11:46 sicam kernel: [46802.944299] [<c062f854>] (dump_stack)=
 from [<c03a57ec>] (check_preemption_disabled+0x110/0x114)
>>> Jun 1 09:11:46 sicam kernel: [46802.944316] [<c03a57ec>] (check_preem=
ption_disabled) from [<c014163c>] (migrate_enable+0x40/0x488)
>>> Jun 1 09:11:46 sicam kernel: [46802.944338] [<c014163c>] (migrate_ena=
ble) from [<c053ff0c>] (ip_finish_output2+0x21c/0x460)
>>
>> Migration should be on across migration-disabled sections, that's thei=
r
>> whole purpose. But maybe the check that preemption needs to be off whe=
n
>> using smp_processor_id needs relaxing to at least migration must be of=
f.
>=20
> Sorry, but I can not follow your words. What do you mean with 'needs re=
laxing to
> at least migration must be off'?
>=20

Strike it, that case is too generic to be a reason for something that
long in the field by now.

From looking at the code of migrate_enable(), I suspect that we cause
the call to smp_processor_id() via "struct rq *rq =3D this_rq();". That
comes fairly at the beginning of migrated_enable(), which matches the
small offset in your backtrace (you can confirm that better). That would
complain about "preemptible code" if the caller does not have preemption
or at least migration off. So my suspect would be a
migration_disable/enable imbalance in the code path you triggered,
likely somewhere in the TCP code.

Did you already try more recent RT kernels, both in the 4.19 series as
well as maybe 5.10 or even latest -rt? Possibly, this issue has been
fixed by now. If you can even reproduce with latest -rt, the issue is
better reported to linux-rt-users.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--QbVUePiN7cHPFhNudgKR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6500): https://lists.cip-project.org/g/cip-dev/message=
/6500
Mute This Topic: https://lists.cip-project.org/mt/83330337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QbVUePiN7cHPFhNudgKR--
