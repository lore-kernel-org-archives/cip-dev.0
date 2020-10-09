Return-Path: <SRS0=vlbG=DQ=lists.cip-project.org=bounce+64572+5516+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A15C433E7
	for <cip-dev@archiver.kernel.org>; Fri,  9 Oct 2020 07:24:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9F422264
	for <cip-dev@archiver.kernel.org>; Fri,  9 Oct 2020 07:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZcYWJWJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9F422264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5516+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pxYGYY4521723xi8DiWFaPK3; Fri, 09 Oct 2020 00:24:24 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.8369.1602228263613327664
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Oct 2020 00:24:24 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 0997OLee008232
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2020 09:24:21 +0200
X-Received: from [167.87.38.61] ([167.87.38.61])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0997OKQR009098;
	Fri, 9 Oct 2020 09:24:21 +0200
Subject: Re: [cip-dev] Backporting of security patches for Intel i40e drivers required?
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSBPR01MB298313D24CA5EF5B0517AB4792080@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <d5baee23-9a71-6994-146d-1b54d42d1ef9@siemens.com>
Date: Fri, 9 Oct 2020 09:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB298313D24CA5EF5B0517AB4792080@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YyIpx1X3yNkSRO9XRUiygoD3x4520388AA=
Content-Type: multipart/mixed; boundary="HCXwT3kY2FdNsfu32D5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602228264;
 bh=9igRk8/l2RsjQWdNPYZdX/Bt7CfHEvi3hr6b+WUqjYk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZcYWJWJHbfqs6xkIGcOyjm/lK02UppjRSO54xXf2ZrFALjCWLReSsa3djFEAnPnCTwn
 gsku6rAsKYRHyOaeg4LDua9BQYyqyfPTxsrogLnevkrQFyEDHO5YYAIqfEcs4vAIRT3VL
 +yD82WJrRuMkeP3IEckUKAdiIldpnH0887k=

--HCXwT3kY2FdNsfu32D5d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

given the exposure of such a device but also the fact that I can't tell
for sure if/where it's used (not only by us), I would recommend backporting.

Jan

On 09.10.20 02:23, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
> 
> I have some comment for this issue.
>   https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20200810/021006.html
>   https://lore.kernel.org/stable/20200807205517.1740307-1-jesse.brandeburg@intel.com/
> 
> There are multiple patches fixed for 4.19, which can be separated by feature.
> 
>  - i40e: add num_vectors checker in iwarp handler
> 
>      This issue has been produced by e3219ce6a7754 ("i40e: Add support for client interface for IWARP driver").
>      e3219ce6a7754 is not included in 4.4.y and can be ignored.
> 
>  - i40e: Wrong truncation from u16 to u8
>    This can be apply in 4.4.y.
> 
>  - i40e: Fix of memory leak and integer truncation in i40e_virtchnl.c
> 
>    This issue has been produced by e284fc280473b ("i40e: Add and delete cloud filter").
>    It is not included in 4.4.y. However, this patch has several different fixes, so some patches need to be applied.
> 
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -181,7 +181,7 @@ static inline bool i40e_vc_isvalid_vsi_id(struct
> i40e_vf *vf, u16 vsi_id)
>   * check for the valid queue id
>   **/
>  static inline bool i40e_vc_isvalid_queue_id(struct i40e_vf *vf, u16 vsi_id,
> -                        u8 qid)
> +                        u16 qid)
>  {
>      struct i40e_pf *pf = vf->pf;
>      struct i40e_vsi *vsi = i40e_find_vsi_from_id(pf, vsi_id);
> 
> 
>  - i40e: Memory leak in i40e_config_iwarp_qvlist
>    This issue has been produced by e3219ce6a7754 ("i40e: Add support for client interface for IWARP driver").
>    e3219ce6a7754 is not included in 4.4.y and can be ignored.
> 
> Best regards,
>   Nobuhiro
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.org] On Behalf Of
>> masashi.kudo@cybertrust.co.jp
>> Sent: Thursday, October 8, 2020 6:43 PM
>> To: cip-dev@lists.cip-project.org
>> Cc: jan.kiszka@siemens.com
>> Subject: [cip-dev] Backporting of security patches for Intel i40e drivers required?
>>
>> Hi, Jan-san, All,
>>
>> At the IRC meeting today, we identified the following new CVEs are not in LTS4.4 yet.
>>
>> - CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 [net/i40e] - Fixed for mainline and 4.19+
>>
>> These are for i40e driver for Intel.
>>
>> The kernel team would like to know whether their backporting is needed or not.
>>
>> For details of those CVE checking results, please see the following.
>> https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/merge_requests/75/diffs
>>
>> Regarding the discussion of the IRC meeting, please see the following.
>> https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-08-09.00.log.html
>>
>> Best regards,
>> --
>> M. Kudo

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--HCXwT3kY2FdNsfu32D5d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5516): https://lists.cip-project.org/g/cip-dev/message=
/5516
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HCXwT3kY2FdNsfu32D5d--
