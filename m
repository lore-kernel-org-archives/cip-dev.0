Return-Path: <SRS0=j/9r=NK=lists.cip-project.org=bounce+64572+6698+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E1C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 08:37:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB4D6109E
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 08:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DB4D6109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VaDCYY4521723xBQLEIRczRI; Thu, 19 Aug 2021 01:37:53 -0700
X-Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web11.66274.1629362271883016779
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Aug 2021 01:37:53 -0700
X-Received: by mail-ot1-f41.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so7758423otk.9
        for <cip-dev@lists.cip-project.org>; Thu, 19 Aug 2021 01:37:51 -0700 (PDT)
X-Gm-Message-State: o34QWpK3iuA5xjkgfUIH03ZMx4520388AA=
X-Google-Smtp-Source: ABdhPJxkinO8z1pNmOTGudzZvVBq5VJ2MucC0owyRHOp50dxo9hjKX1xd6CmvvvtyR6C37xc3/BQx/s2Fwki6f8V21o=
X-Received: by 2002:a05:6830:1df8:: with SMTP id b24mr9868201otj.106.1629362270895;
 Thu, 19 Aug 2021 01:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9ra5A_NkvqgPMhXc8PR17gaC+R3FU4mfA-_scKGo1Mspw@mail.gmail.com>
 <20210819071021.GB32099@amd>
In-Reply-To: <20210819071021.GB32099@amd>
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Aug 2021 17:37:15 +0900
Message-ID: <CAODzB9pFHgXZxRmHHE-X795Qvjm4hfn-dXkE_Y2qiqF+MXf6kg@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="B2STJuroNcQwIb8s9z3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629362273;
 bh=iwI3xr5uHEEtkGYQLtelfTIlQavaAicGGCNXB242M3A=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=RUkHL2ILVrt3EvDc2Su+XOTNviGeoNTSoHfVkL9E5FYQAGXrqRRUEMKZD/+MX/LCwgw
 0kBUGrRnZVp0bGHueyVLGkIzV+twebp1gUBy1eK+g9vFJjIoWb3E09RPH1SMYW/x3Masb
 Vpn8SOWmbPkFTCeL5LgxKfCHEsp9yRXjaCg=

--B2STJuroNcQwIb8s9z3P
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Aug 19, 2021 at 4:10 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
>
> > CVE-2021-38198: KVM: X86: MMU: Use the correct inherited permissions
> > to get shadow page
> >
> > This vulnerability has been introduced since 2.6.20-rc4 so 4.4 affects
> > this CVE but patch didn't apply to 4.4
> > (https://lore.kernel.org/stable/162358450944186@kroah.com/). 4.19 also
> > failed to apply this patch but backport patch has been merged
> > recently(https://lore.kernel.org/stable/20210812174140.2370680-1-ovidiu.panait@windriver.com/).
> >
>
> I tried to look at this, and it is rather non-trivial. In particular,
> I'd not know how to test it. I ended up with this patch, but it is not
> even compile-tested.
>
> Best regards,
>                                                                 Pavel
>
> diff --git a/Documentation/virtual/kvm/mmu.txt b/Documentation/virtual/kvm/mmu.txt
> index b653641d4261..ee5bd16a0856 100644
> --- a/Documentation/virtual/kvm/mmu.txt
> +++ b/Documentation/virtual/kvm/mmu.txt
> @@ -152,8 +152,8 @@ Shadow pages contain the following information:
>      shadow pages) so role.quadrant takes values in the range 0..3.  Each
>      quadrant maps 1GB virtual address space.
>    role.access:
> -    Inherited guest access permissions in the form uwx.  Note execute
> -    permission is positive, not negative.
> +    Inherited guest access permissions from the parent ptes in the form uwx.
> +    Note execute permission is positive, not negative.
>    role.invalid:
>      The page is invalid and should not be used.  It is a root page that is
>      currently pinned (by a cpu hardware register pointing to it); once it is
> diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> index 7be8a251363e..cebcf7b29b15 100644
> --- a/arch/x86/kvm/paging_tmpl.h
> +++ b/arch/x86/kvm/paging_tmpl.h
> @@ -100,8 +100,8 @@ struct guest_walker {
>         gpa_t pte_gpa[PT_MAX_FULL_LEVELS];
>         pt_element_t __user *ptep_user[PT_MAX_FULL_LEVELS];
>         bool pte_writable[PT_MAX_FULL_LEVELS];
> -       unsigned pt_access;
> -       unsigned pte_access;
> +       unsigned int pt_access[PT_MAX_FULL_LEVELS];
> +       unsigned int pte_access;
>         gfn_t gfn;
>         struct x86_exception fault;
>  };
> @@ -354,6 +354,9 @@ retry_walk:
>                 pte_access = pt_access & FNAME(gpte_access)(vcpu, pte);
>
>                 walker->ptes[walker->level - 1] = pte;
> +
> +               /* Convert to ACC_*_MASK flags for struct guest_walker.  */
> +               walker->pt_access[walker->level - 1] = FNAME(gpte_access)(pt_access ^ walk_nx_mask);
>         } while (!is_last_gpte(mmu, walker->level, pte));
>
>         if (unlikely(permission_fault(vcpu, mmu, pte_access, access))) {
> @@ -392,10 +395,11 @@ retry_walk:
>                         goto retry_walk;
>         }
>
> -       walker->pt_access = pt_access;
> -       walker->pte_access = pte_access;
> +       walker->pt_access = FNAME(gpte_access)(pt_access ^ walk_nx_mask);
> +       walker->pte_access = FNAME(gpte_access)(pte_access ^ walk_nx_mask);
>         pgprintk("%s: pte %llx pte_access %x pt_access %x\n",
> -                __func__, (u64)pte, pte_access, pt_access);
> +                __func__, (u64)pte, walker->pte_access,
> +                walker->pt_access[walker->level - 1]);
>         return 1;
>
>  error:
> @@ -555,7 +559,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
>  {
>         struct kvm_mmu_page *sp = NULL;
>         struct kvm_shadow_walk_iterator it;
> -       unsigned direct_access, access = gw->pt_access;
> +       unsigned int direct_access, access;
>         int top_level, emulate = 0;
>
>         direct_access = gw->pte_access;
> @@ -586,6 +590,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
>                 sp = NULL;
>                 if (!is_shadow_present_pte(*it.sptep)) {
>                         table_gfn = gw->table_gfn[it.level - 2];
> +                       access = gw->pt_access[it.level - 2];
>                         sp = kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
>                                               false, access, it.sptep);
>                 }
>
>

Thank you for the patch. I looked at both original
patch(b1bd5cba3306691c771d558e94baa73e8b0b96b7) and your's.
This patch looks good to me.

> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--B2STJuroNcQwIb8s9z3P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6698): https://lists.cip-project.org/g/cip-dev/message/=
6698
Mute This Topic: https://lists.cip-project.org/mt/84986288/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--B2STJuroNcQwIb8s9z3P--
