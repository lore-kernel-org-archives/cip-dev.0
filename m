Return-Path: <SRS0=wli7=NK=lists.cip-project.org=bounce+64572+6696+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848A2C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 07:10:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBE5610A7
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 07:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CBE5610A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SmlnYY4521723xqkZqCsye2K; Thu, 19 Aug 2021 00:10:33 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.66659.1629357031130675181
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Aug 2021 00:10:32 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C85891C0B77; Thu, 19 Aug 2021 09:10:25 +0200 (CEST)
Date: Thu, 19 Aug 2021 09:10:22 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210819071021.GB32099@amd>
References: <CAODzB9ra5A_NkvqgPMhXc8PR17gaC+R3FU4mfA-_scKGo1Mspw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9ra5A_NkvqgPMhXc8PR17gaC+R3FU4mfA-_scKGo1Mspw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2LVfTcpg9Bq0ZfqtUu2efiRYx4520388AA=
Content-Type: multipart/mixed; boundary="uBrpxTGRFyngY904q4kN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629357033;
 bh=QraL7zcY+M12SufA2nBmaiLKrNLynJ3FNn4oeyP+Jck=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=uMO6v9YnFuvw17X/cCH/C1CORGrhmw7SRDRuN/D4qWNv8fP6q9TkoEY+/g0etZJRdUc
 q3QrwRAs3mJaC8nPpFKp3K8TT1LwrIpGZ6oDAGJUQAUUEvsM4BwqotvAz4SiFTcmR2gF/
 2Kw8R3QbuV2XMvYWd/7qk2Up1HAH++eaGkg=

--uBrpxTGRFyngY904q4kN
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> CVE-2021-38198: KVM: X86: MMU: Use the correct inherited permissions
> to get shadow page
>=20
> This vulnerability has been introduced since 2.6.20-rc4 so 4.4 affects
> this CVE but patch didn't apply to 4.4
> (https://lore.kernel.org/stable/162358450944186@kroah.com/). 4.19 also
> failed to apply this patch but backport patch has been merged
> recently(https://lore.kernel.org/stable/20210812174140.2370680-1-ovidiu.p=
anait@windriver.com/).
>=20

I tried to look at this, and it is rather non-trivial. In particular,
I'd not know how to test it. I ended up with this patch, but it is not
even compile-tested.

Best regards,
								Pavel

diff --git a/Documentation/virtual/kvm/mmu.txt b/Documentation/virtual/kvm/=
mmu.txt
index b653641d4261..ee5bd16a0856 100644
--- a/Documentation/virtual/kvm/mmu.txt
+++ b/Documentation/virtual/kvm/mmu.txt
@@ -152,8 +152,8 @@ Shadow pages contain the following information:
     shadow pages) so role.quadrant takes values in the range 0..3.  Each
     quadrant maps 1GB virtual address space.
   role.access:
-    Inherited guest access permissions in the form uwx.  Note execute
-    permission is positive, not negative.
+    Inherited guest access permissions from the parent ptes in the form uw=
x.
+    Note execute permission is positive, not negative.
   role.invalid:
     The page is invalid and should not be used.  It is a root page that is
     currently pinned (by a cpu hardware register pointing to it); once it =
is
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 7be8a251363e..cebcf7b29b15 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -100,8 +100,8 @@ struct guest_walker {
 	gpa_t pte_gpa[PT_MAX_FULL_LEVELS];
 	pt_element_t __user *ptep_user[PT_MAX_FULL_LEVELS];
 	bool pte_writable[PT_MAX_FULL_LEVELS];
-	unsigned pt_access;
-	unsigned pte_access;
+	unsigned int pt_access[PT_MAX_FULL_LEVELS];
+	unsigned int pte_access;
 	gfn_t gfn;
 	struct x86_exception fault;
 };
@@ -354,6 +354,9 @@ retry_walk:
 		pte_access =3D pt_access & FNAME(gpte_access)(vcpu, pte);
=20
 		walker->ptes[walker->level - 1] =3D pte;
+
+		/* Convert to ACC_*_MASK flags for struct guest_walker.  */
+		walker->pt_access[walker->level - 1] =3D FNAME(gpte_access)(pt_access ^ =
walk_nx_mask);
 	} while (!is_last_gpte(mmu, walker->level, pte));
=20
 	if (unlikely(permission_fault(vcpu, mmu, pte_access, access))) {
@@ -392,10 +395,11 @@ retry_walk:
 			goto retry_walk;
 	}
=20
-	walker->pt_access =3D pt_access;
-	walker->pte_access =3D pte_access;
+	walker->pt_access =3D FNAME(gpte_access)(pt_access ^ walk_nx_mask);
+	walker->pte_access =3D FNAME(gpte_access)(pte_access ^ walk_nx_mask);
 	pgprintk("%s: pte %llx pte_access %x pt_access %x\n",
-		 __func__, (u64)pte, pte_access, pt_access);
+		 __func__, (u64)pte, walker->pte_access,
+		 walker->pt_access[walker->level - 1]);
 	return 1;
=20
 error:
@@ -555,7 +559,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t ad=
dr,
 {
 	struct kvm_mmu_page *sp =3D NULL;
 	struct kvm_shadow_walk_iterator it;
-	unsigned direct_access, access =3D gw->pt_access;
+	unsigned int direct_access, access;
 	int top_level, emulate =3D 0;
=20
 	direct_access =3D gw->pte_access;
@@ -586,6 +590,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t ad=
dr,
 		sp =3D NULL;
 		if (!is_shadow_present_pte(*it.sptep)) {
 			table_gfn =3D gw->table_gfn[it.level - 2];
+			access =3D gw->pt_access[it.level - 2];
 			sp =3D kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
 					      false, access, it.sptep);
 		}


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEeA90ACgkQMOfwapXb+vIj0gCeMNb3vIEaUMhZNWmGUB//vdqk
mLEAoK2d+8eyc/FUQOXK+cVvZ+9czUxB
=ZKfO
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--

--uBrpxTGRFyngY904q4kN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6696): https://lists.cip-project.org/g/cip-dev/message/=
6696
Mute This Topic: https://lists.cip-project.org/mt/84986288/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uBrpxTGRFyngY904q4kN--
