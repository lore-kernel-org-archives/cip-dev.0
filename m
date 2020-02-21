Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB1C11D00
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 01:16:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CACA208E4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 01:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CACA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E24B87E72;
	Fri, 21 Feb 2020 01:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vSPd3JBp8XqO; Fri, 21 Feb 2020 01:16:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D44A987E6F;
	Fri, 21 Feb 2020 01:16:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7C9AC013E;
	Fri, 21 Feb 2020 01:16:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9783C013E;
 Fri, 21 Feb 2020 01:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D22B686222;
 Fri, 21 Feb 2020 01:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUDc-pVXFded; Fri, 21 Feb 2020 01:16:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 779CD861CE;
 Fri, 21 Feb 2020 01:16:02 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 01L1G0od000431;
 Fri, 21 Feb 2020 10:16:00 +0900
X-Iguazu-Qid: 34tKIIhGyby03gGDXE
X-Iguazu-QSIG: v=2; s=0; t=1582247760; q=34tKIIhGyby03gGDXE;
 m=1R9GDLzxO4dbXO0ee0oxlDQu6c+BJ/Sxp92cq8kzHJI=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1511) id 01L1FxWJ033645;
 Fri, 21 Feb 2020 10:16:00 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 01L1Fxvn011234;
 Fri, 21 Feb 2020 10:15:59 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 01L1FxVs026426;
 Fri, 21 Feb 2020 10:15:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLtqbyVY/oRAktKh4OJAlakoUu1LworqtEqoXw8FXXUnSq374v2179zuF3VFqFGQzs726CPwxzzufyI20nMX2fpBBr0aTUWp4NshWgkYKvwYecIEMZdyQQ9ozNiRLkVJ1BE1F4/EmdrJkUGIhTOtQ4fC2k8p5Y6ChTIyA2g7hMBG9HQ5Vdbm3ecyBEWNjUfxPiWXEvM1T2lWrC65H31EtkdTQwxHRVVNiU5emAC0MX5h7BIhD92e8BjeofRulpF3eyy+udORPGNywaVY2qCVUBjQS1ERZDpEd2r97JHq0bbyGIid8JjT6HaoQx3cq9lPsxGHTQ2V7ziGro/exvaDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu+4+VBSQBdWpC+EoME4AbY01mFgkDB93lRVtUR5k7c=;
 b=jZ9+FxCO03GttjapF3sopWRXeulLAbWvq8F8c2U96MwbA5QustfLfQLJtfMCjTdSNVqrp7YthhECaT3SKbyrgpDWpPQC3+J4VEjPYoLG1ndxuLgO4SoZV6WONvRqwsrYdbyaiIGYcXj6q9XSq5sp9WcoTI7lSjwzhN59BddYMYZYna1ue48YSlJqGxQLaptWH1bt3KLYfXNVgdvtgk1yYO6pAu7k5s2Wewmim1m946Y6neZCm5FH/Qnreyvh/CbCw/RvmYh8KbvY8fW/hwt4HOMeeDdcY24KYFNCg4Bb9NfkOUl3SkshKoGoS/2E+TlXMHMOjzXRh6iKKdTrUpkmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <kento.yoshida.wz@renesas.com>
Thread-Topic: Package Proposal #1 (Security packages), rev03
Thread-Index: AdXhPVMXFwdvSCDCQN63lDtGohpPbgBnARowAV2njFA=
Date: Fri, 21 Feb 2020 01:15:55 +0000
X-TSB-HOP: ON
Message-ID: <TYXPR01MB180846C5AF70AB40B2AAD116E1120@TYXPR01MB1808.jpnprd01.prod.outlook.com>
References: <TYAPR01MB23996D34ED0281C405A6C34CDF1B0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <TYXPR01MB18087F36FC412ADF27A97F9AE1150@TYXPR01MB1808.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB18087F36FC412ADF27A97F9AE1150@TYXPR01MB1808.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kazuhiro3.hayashi@toshiba.co.jp; 
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84a05d9c-177e-4c0a-6c93-08d7b66b9a7f
x-ms-traffictypediagnostic: TYXPR01MB1661:
x-microsoft-antispam-prvs: <TYXPR01MB166178EB7DD3BBECF7B30032E1120@TYXPR01MB1661.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(186003)(6506007)(7696005)(66946007)(76116006)(8936002)(81166006)(53546011)(26005)(478600001)(66476007)(66446008)(33656002)(966005)(66556008)(2906002)(64756008)(81156014)(30864003)(4326008)(110136005)(71200400001)(86362001)(52536014)(55016002)(5660300002)(8676002)(9686003)(316002)(15650500001)(17413003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:TYXPR01MB1661;
 H:TYXPR01MB1808.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y9BvB7IgRmtos0CH/iNQm1xjQNCa4QKtxAwW9HRkPorOSUlY/elODDXv5ph3iFD0ItwjO5csKHhHTX9zHGPcCAKdCPP2w76Xzu7Ool/kayxr2EWZLKLSbFcUWd+aB5QGoJuVUIufk3veF5c4gv83iTkAgGcC93QXZ2wz5Cf25ASuIhDJmjtq7RcQmc31+D2lnLZqyEtd2dgAj/znFW6YAeL5d4wxE0URqc17E1kpu2qrDMgaK4Rf6g9XXm6tYgaDjcjHhkDBX0OeAJ9f4+dRwXivbfW9Sje5ZVn3t12VFaCTltdUtLOGAITfEynpFYfaM7wG6bl+8XW2XtOA2nvp1vTxt0QHvpf/SH4pHCzlCO4GJNGZE+ALzDcxl8ixXWAX1SzWsaPuSpReu8pvMV4YhkYrN1c9PY7CJ3PdoTa4fYK8Bmvcc4IBBKFh6eC8aHHFGswk4KtAec8swVrIxkQP0UH8q8135i5Q4X+ruHVwVc+0na9T1GWCk50O8woMkb4GcRF/Ew9ARQWauSG4YRfjSvC9wEH19BC83aUIrCgo2FUnslNlr8jr2vGJOyWiCzsP
x-ms-exchange-antispam-messagedata: z+GyWl1KGg0jWjOE4oscqbn7mq6Xhqlpk1h0UyqkTMjmC4/VznzB4aXj8dHZIN3R4hH81hVxN6TfyktW74miW+czOt0o5IlFlXGTtJs95WZ0HIAPezPtb11Bq3Fnk+DM7Ubt4myfRRoNMtiuYSzG0g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a05d9c-177e-4c0a-6c93-08d7b66b9a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 01:15:55.8366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pmq/3z24/1IyxNab1MGTDsGcffp2xyXXQ4hZoyZQLmyhTl7GKGIfp8KxLtCJmCnBoS1L9ivld+w2/F0JVtxRKMAR6Hv7goiMUSvtXiZg8Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1661
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: cip-security@lists.cip-project.org
Subject: Re: [cip-dev] Package Proposal #1 (Security packages), rev03
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hello all,

We discussed with security WG members yesterday then
decided to SUSPEND this proposal process for a while.

The reasons of the suspending is that CIP (reviewers) need more information
to understand the required security features (and functional relations with the packages).
In order to get the information, we are planning to follow the steps below:

1. CIP Core provides "sample" images including the proposed packages (+ more if required)
   so that CIP members (mainly security WG) can "evaluate" the required security features
   using the actual run-time environment.
2. CIP Security confirm whether the packages can satisfy the security requirements
   (by testing manually or creating test cases), one by one
3. Based on the result in 2, CIP Security refine this package proposal if needed
   and resume the package proposal

CIP Core has started to create the sample image for the evaluation.
This activity will be discussed in another thread.

Best regards,
Kazu

> -----Original Message-----
> From: Cip-security [mailto:cip-security-bounces@lists.cip-project.org] On Behalf Of kazuhiro3.hayashi@toshiba.co.jp
> Sent: Friday, February 14, 2020 11:05 AM
> To: kento.yoshida.wz@renesas.com; cip-dev@lists.cip-project.org
> Cc: cip-security@lists.cip-project.org
> Subject: Re: [Cip-security] Package Proposal #1 (Security packages), rev03
> 
> Hello Kent,
> 
> Thank you for updating the proposal.
> 
> Dear reviewers,
> 
> First, please confirm the attachment in Kent's mail, especially
> the "Proposal description" sheet in "Requirements_for_proposal_SecurityWG_rev03.xlsx",
> which includes "detail description" of top level security packages (18 packages).
> After that, we can check more details in .yml file (like dependencies)
> based on our agreements about the 18 packages.
> 
> Due date: February 21, Friday
> 
> I think this duration might be short to check all information in .yml file,
> but it's enough to confirm the information in "Proposal description" in .xlsx
> or just to start the discussion about them.
> 
> Best regards,
> Kazu
> 
> > Could you proceed this proposal? Thank you for many cooperation.
> 
> >
> > Hello CIP core group members,
> >
> > I'd formally like to propose to add security packages as revision 3.
> > I've already the description sheet before, but I'll share all files for this review again in this mail.
> >
> > Contents:
> >  proposal_SecurityWG_rev03.yml: the full flat proposal file including all source and binary sets with reason, security
> > tag information and so on
> >  Requirements_for_proposal_SecurityWG_rev03.xlsx: the same file which I've already sent before to explain the requirement
> > in the standard
> >  2_src-bin_sort_SecurityWG.txt: the 95 proposed package lists simplified with source and binary names
> >  2_src-bin_sort_all.txt: the 179 package lists consisted of the 95 lists for this proposal and the 84 lists already
> approved
> > by CIP core as a minimal base shown in brackets
> >
> > I'd like to set the due date for reviewing this proposal by February 21, Friday.
> > It would be very helpful if I can get your feedback, concerning or question in this week due to resolve by the due date.
> >
> > @kazuhiro3.hayashi@toshiba.co.jp,
> > Could you proceed this proposal? Thank you for many cooperation.
> >
> > Thank you all for considering my request,
> > Kent
> >
> > >-----Original Message-----
> > >From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Kento Yoshida
> > >Sent: Friday, February 7, 2020 5:58 PM
> > >To: Punit Agrawal <punit1.agrawal@toshiba.co.jp>;
> > >kazuhiro3.hayashi@toshiba.co.jp
> > >Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> > >Subject: Re: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1 (Security
> > >packages)
> > >
> > >Hello reviews,
> > >
> > >Thank you for your supporting against our proposal.
> > >I'd like to share you the description sheet for our proposal of security packages.
> > >Please consider my attachment and the following note.
> > >
> > >Note:
> > >1. Added "fail2ban" as the alternative "pam-shield" because "pam-shield" is not
> > >well-maintained and replace with "fail2ban"
> > >2. There are 3 packages in bottom that are under discussion to add. They are out of
> > >scope for this review but I'd like to explain them, so let me know your ideas if you
> > >have.
> > >3. The requirements for hardware functions are out of scope for this review, but
> > >tpm2 is concrete example mentioned in the standard, so I'd like to add some
> > >packages related tpm2. However, they are options for only using tpm2, so let me
> > >know your comments against adding the packages for a specific use case.
> > >
> > >BTW,
> > >
> > >@kazuhiro3.hayashi@toshiba.co.jp,
> > >
> > >I'd like to create new proposal to add "fail2ban", but the script for generating
> > >proposal shows the following error, and I could not generate it.
> > >
> > >-------------------------------
> > >Source package name:
> > >Binary packages:
> > >
> > >any>
> > >Traceback (most recent call last):
> > >  File "./generate-proposal.py", line 218, in <module>
> > >    generate_proposal(common.PDPProposal.ProposalInfo())
> > >  File "./generate-proposal.py", line 176, in generate_proposal
> > >    deb_src_pkg_info = prepare_src_pkg_info(apt, cve, dep_src_pkg,
> > >dep_pkg_info.keys())
> > >  File "./generate-proposal.py", line 51, in prepare_src_pkg_info
> > >    dp_list_final = gpd.get_pkg_depends(pkg, apt)
> > >  File "/home/yoshidak/cip-pkglist/get_pkg_depends.py", line 102, in
> > >get_pkg_depends
> > >    dp_list, dp_vir_pkg_dict = apt.apt_cache_get_depends_list(pkg_name)
> > >  File "/home/yoshidak/cip-pkglist/common.py", line 222, in
> > >apt_cache_get_depends_list
> > >    dp_info=c[pkg_name]
> > >  File "/usr/lib/python2.7/dist-packages/apt/cache.py", line 238, in __getitem__
> > >    raise KeyError('The cache has no package named %r' % key)
> > >KeyError: "The cache has no package named 'any>'"
> > >-------------------------------
> > >
> > >I think that the reason is below. When I enter the information of "fail2ban", the
> > >script get the dependency for it as <python3:any>.
> > >
> > >-------------------------------
> > >Enter the source package name: fail2ban
> > >Choose the required binary packages:
> > >        1: fail2ban
> > > Input the numbers in comma separated (eg: 1,3,4): 1
> > >
> > >fail2ban
> > > Choose one of the virtual package provider: <python3:any>
> > >        1: python3
> > > Input the number: 1
> > >        -<python3:any>:python3
> > >        -lsb-base
> > > Are any of the binary packages used in target rootfs?
> > >        1: True
> > >        2: False
> > >-------------------------------
> > >
> > >Would you confirm this issue?
> > >
> > >Best regards,
> > >Kent
> > >
> > >>-----Original Message-----
> > >>From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> > >>Sent: Thursday, January 23, 2020 4:35 PM
> > >>To: Kento Yoshida <kento.yoshida.wz@renesas.com>
> > >>Cc: cip-dev@lists.cip-project.org; cip-security@lists.cip-project.org
> > >>Subject: Re: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1
> > >>(Security
> > >>packages)
> > >>
> > >>Thank you for your comments, Yoshida-san. Follow up comments inline.
> > >>
> > >>Kento Yoshida <kento.yoshida.wz@renesas.com> writes:
> > >>
> > >>> Hello and thank you for your comment, Punit,
> > >>>
> > >>>>-----Original Message-----
> > >>>>From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> > >>>>Sent: Monday, January 20, 2020 7:29 PM
> > >>>>To: Kento Yoshida <kento.yoshida.wz@renesas.com>
> > >>>>Cc: cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp;
> > >>>>cip-security@lists.cip-project.org
> > >>>>Subject: Re: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1
> > >>>>(Security
> > >>>>packages)
> > >>>>
> > >>>>Hello Yoshida-san,
> > >>>>
> > >>>>Kento Yoshida <kento.yoshida.wz@renesas.com> writes:
> > >>>>
> > >>>>> Hello,
> > >>>>>
> > >>>>> I would like to resume our proposal from security working group.
> > >>>>> As you know, Kazu has modified the script to generate a proposal
> > >>>>> and posted the
> > >>>>minimum base system proposal, and then I created the new proposal.
> > >>>>>
> > >>>>> The difference from the original (rev01) proposal is below:
> > >>>>> 1. We remove 'duplicity', 'google-authenticator', 'pam-shield' and
> > >>>>> 'suricata' in the
> > >>>>new proposal because they have an issue such as non-well maintained,
> > >>>>python version, too much dependencies and so on. We'll separately
> > >>>>propose them after solved these issues.
> > >>>>> 2. The new proposal shows all source package as flat. Thanks to the
> > >>>>> new script,
> > >>>>Kazu!
> > >>>>> 3. Actually several packages overlap with the proposed packages for
> > >>>>> minimum
> > >>>>base system in Debian, so I added comment them like that.
> > >>>>>
> > >>>>> @kazuhiro3.hayashi@toshiba.co.jp,
> > >>>>> Would you check this proposal and set the due date to review it?
> > >>>>>
> > >>>>> Please reply if you have any comments or questions.
> > >>>>
> > >>>>I have a comment about packages in the proposal that depend on
> > >>>>hardware / system features -
> > >>>>
> > >>>>* Some packages in the proposal depend on special purpose hardware to
> > >>>>  provide their functionality. e.g., TPM.
> > >>>>
> > >>>>  In systems, where TPM is not present (or similar functionality is
> > >>>> provided by alternate mechanisms), the TPM related packages will not
> > >>>> be useful. e.g., the non-x86 platforms in the CIP reference hardware
> > >>>> list.
> > >>>>
> > >>>>* Similarly, some packages require the system to be connected to the
> > >>>>  network.
> > >>>>
> > >>>>In both of these situations, I am wondering what is the impact on
> > >>>>compliance? Is there a need to also define minimal set of hardware
> > >>>>features expected from reference hardware to be able to meet
> > >>>>compliance
> > >>requirements?
> > >>>>
> > >>>
> > >>> How each reference hardware satisfies the requirements should be
> > >>> considered by each reference hardware provider.
> > >>
> > >>Agreed.
> > >>
> > >>But without an explicit statement of the requirement, how can a
> > >>hardware vendor wanting to develop system for CIP users know what
> > >>features to enable in their system?
> > >>
> > >>> If we provide hardware mechanisms similar with TPM to protect
> > >>> credentials and authentications, we can meet compliance requirements.
> > >>
> > >>TPM2 specification is more than 2000 pages long with many features and
> > >>functions. I believe the IEC standard requires a subset of this
> > >>functionality. The Security WG maybe intimately familiar with the
> > >>required features but for the reviewers on this list, there isn't any criteria to use
> > >for evaluation.
> > >>
> > >>Stating these functional requirements explicitly will serve the dual
> > >>purpose of -
> > >>
> > >>* Provide an objective criteria for evaluating the package proposal
> > >>(and
> > >>  discuss alternatives)
> > >>
> > >>* Give hardware / system vendors the features / functions needed by CIP
> > >>  users.
> > >>
> > >>What do you think?
> > >>
> > >>> TPM related packages are options in only systems where TPM is
> > >>> implemented as you said. If supporting these packages require too
> > >>> much costs, the necessity of them will diminish.  Actually the
> > >>> standard lists TPM as a typical example, so we thought it will be
> > >>> useful to maintain TPM related packages for many users, but their
> > >>> necessities depend on supporting cost.
> > >>
> > >>I see - thanks for the background of the TPM-related packages in the proposal.
> > >>
> > >>>
> > >>>>To help review the package list (and also discuss alternatives), it
> > >>>>would help to define the underlying functionality that is required in
> > >>>>more detail, e.g., secure key storage, verified boot, etc. It'll make
> > >>>>it possible review the proposal more concretely.
> > >>
> > >>[...]
> 
> _______________________________________________
> Cip-security mailing list
> Cip-security@lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-security
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
