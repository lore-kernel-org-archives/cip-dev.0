Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06542C433EF
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 08:00:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.9410.1637827213840365576
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 00:00:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1AP80AKu004803;
 Thu, 25 Nov 2021 17:00:10 +0900
X-Iguazu-Qid: 2wHHbCQQkZQ73PLFUv
X-Iguazu-QSIG: v=2; s=0; t=1637827210; q=2wHHbCQQkZQ73PLFUv;
 m=J8bIaHUZ8u/Pp7AAKJbY0FpWfRinXiKSBkBZwyQzvJc=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 1AP809xm019657
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Nov 2021 17:00:09 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 3DAF5100114
	for <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 17:00:09 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AP808LR018189
	for <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 17:00:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2+iLSUv+pm24IBdADPwIWS/v5tbSrXdhRo0W/FfYV0X2JAYOfZY2qmULxpQvH8J0pRz1terCLXSkSxzmWQTyjGFLBqHNDMy/O8X/aWx7IY/Yvfc9zSNR6noOXqCtUEV0caj4BklKKELMOSQ7lW9oatYWEvI2ux/ZhvkCovbeHUjslLUaoIoirs9XtEiv24uv0u2cYWcTGjawc8DrFjirjdnLKjwJnq0qkOYJFUytnqzDxhpfbbNl/kt5XpQ4IpMuDf4npKFfDppsQWMoupUCqrpaT3LXQoZpTKNmNhYcGrKSrABDYqtKb1/1SSR8bVZpq2h/tHLh0HMdOD1ZVo9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9CZ6KV6MxJChIPm+yw+CYQ25ULcY3Gv0mbCLenFpHU=;
 b=Zfwrc/+vrNP7FFhPASFQZV+eZSZmoD6ONjy5P27EEA9pvgeBEBfLePWFF/dCKnu9WhdI36hXRc2nPMErqxD36jrMOSaN3D6Bwx8K+Jd4jORTFN7GVtnXkXghmXpMcQnFiWSxVQA2TVdOIobzDiDRLa/SLIX4Xv3aPB9IfKSZl99mvMcE+cUfl6F5ajThuA2LORJLe2CFTwCAFenCQWTi5CZh0m64SSwEVakE7LArDXoLO75NuEO2YmqIBjePHvepM4Ek07oHfjiOSyOJIGETts4s+setRKLhFeIIQltL39omjzKjFPCXgz5jUPlE5zWQabQpZLVWtqIc1jM66rkbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] New CVE entries in this week
Thread-Topic: [cip-dev] New CVE entries in this week
Thread-Index: AQHX4bvA8VOAtJVW+ECPY3BeCY8wf6wT3I2Q
Date: Thu, 25 Nov 2021 08:00:04 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB625214AA3D666DCAF383397892629@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <16BAA9D56D09F20A.23256@lists.cip-project.org>
 <CAODzB9pm61qjStFZ9_GW-w-M2nqiUyrk1aR3-fJhkzfSyNpx-g@mail.gmail.com>
In-Reply-To: 
 <CAODzB9pm61qjStFZ9_GW-w-M2nqiUyrk1aR3-fJhkzfSyNpx-g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: ade26143-407e-9c9a-812a-22b9da6d08a0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e008f22-950a-42a3-b6a9-08d9afe996c7
x-ms-traffictypediagnostic: TY2PR01MB5259:
x-microsoft-antispam-prvs: 
 <TY2PR01MB5259B460AAFA15E6575AFD9692629@TY2PR01MB5259.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vh1qyW3hoMh/rmjeN+ADleRq7h2/IHCU2p5wWWLztnycDkx9rra6o/uxIJ5wMwXeuGJP0Pob4VE8oivbi5ReueCveZwB2IhAOAUyvmqMX5Z7mrqQ1TsTNSlnFTEPCIyUKh/CxkCHEbpvJ+GWg3gPM7Q0G8ETKcrgGS8cMOEQU4ruGkg96HWuM/QW8VRw1o8kLUWDiDhIzzQIdeIyxcaTKIEEHHiVH5r9emQ5RxrXdovRccoq+Nh1/qgkHXmRfEAIVsVMBdUaW5admpIJXhgHLMBj4wgT8UxFCMirCAUMXTgWH8sPdPn9C/U4t1n23IHt/NeIRhL6LlHYdD8XrWBTXe03jZBAeWHYhufa8AfbgPB8PliqzxoqHEJXKWRxvNxgId9i8cI3rQwevcURIpb+h64HNhtOKrPgBlebW7ISsxqh0vtubO4g4m6urMCUYkq6DRBeHAvUx2hDh5BfTTra5v1wCXd3Qb3FdNn8VrOa3BD7CkE/s2xv6DfHdlcC21sLKByMbwXKDdNERbkduEahT7a43iHM3U1lAemMVJyYdUxD+a1J5WM/1fdjSzXp68ldxiJRfJQYIJZMlI6t+yk0e3SSw1RrMFgq2dOsgtM4EFLi6rs2WiYScxD9SYNfBEFWgB48xs97k8uXyUkemOMqhGWUaAFrXmO2P/9EnVT5xkaC3puB9lkCY6pqwiXdA1MV4LWcrma9txQc+5qckXT592+qjP++j4J+PPOPqLdqx/dMXvjcaHABAGA7E/8SKiD3/KC/YOjr/CLs6wPXpAQikNY3e0ndOQDrfKYBoW8BKmil9xcHZ/VZYmJt2aOCbSSgay2ZniH14e0pxbVUNzl4rw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38100700002)(71200400001)(76116006)(66556008)(66446008)(53546011)(6506007)(52536014)(86362001)(66946007)(55016003)(33656002)(966005)(8936002)(64756008)(38070700005)(5660300002)(66476007)(26005)(6916009)(122000001)(316002)(55236004)(7696005)(186003)(83380400001)(9686003)(2906002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MjNRS2pNYWhDckpEeTlWNTE1NGp2SzhjYzlXd3pJQTRSSURla1VJbjdJ?=
 =?iso-2022-jp?B?eDhWdFJLQ2JMYzg5Qk43emg2MjVTMm02aWVKNi9XYzhlNkh0YWZwejlF?=
 =?iso-2022-jp?B?ZmFzVkllTVRpMFVxV0c0RnpJbHQ5NjFTNFNFUnduNkVmbzEvdmk1Q2k0?=
 =?iso-2022-jp?B?REdBNzBvbExVNzg0TkJ3WGdycDFueStIOXFqM1p1c1crSzlHUDlVVmRK?=
 =?iso-2022-jp?B?dUMwSlhkRTJUdmpMVVRUbFB0V0k0b3A1bkFVQ3lwSHVQKytNZFhmeCtC?=
 =?iso-2022-jp?B?ejJtQ3cvNXgzMnRDM2J1NFphSURZM1Yza0dQQUJEdnNZVVJOUzdlM05W?=
 =?iso-2022-jp?B?b2JubkJ2NE04NGlnNkZNaUw4dHIzTTJpTGRzcFZHeVh6MkdBR01yMWYr?=
 =?iso-2022-jp?B?aEFXOFBOT2ZGL1BkKzFlZmU2cXNwcGt2ZDRGcVN0N282Q2NzMXlneTVL?=
 =?iso-2022-jp?B?MDhYb2pyRVhnSWhhZWtrdngxUUNSVEFuZ2FQaGxXbU5DdWk3OFRtKzVO?=
 =?iso-2022-jp?B?TzVlVENCSzhlWk4yZUwzNUZsT0p6YmY1dG9SRS9pWlBHRnFxU0pNOVFt?=
 =?iso-2022-jp?B?SUtHbDM2VUFjSDdtZHhxSEE2YjBRdVpYSXdQclpUVVdxVkNRSlpwQ0JI?=
 =?iso-2022-jp?B?cUxDRDEwb1RMR2FqZGc0cjV2dDlVaDN6WUUxWXRNOFFjQ2pOK2UyanVt?=
 =?iso-2022-jp?B?S004ekV3dE9zbnl6VzFpUVZDckM0ZFBzdWpIOExWRGM4dDY5Um1LOGw0?=
 =?iso-2022-jp?B?amt0NG5qRkR2cEtFTUdhb2wrVm9sMFhYWmhHQklobklGNU9uaUpIQkll?=
 =?iso-2022-jp?B?VnlSOGlHS3JMemVvWUxvdUxCNG5BNS9vTTRmcFFLUm9BdXBqNk5vRnJ0?=
 =?iso-2022-jp?B?VW44TC9MdnBRTXFUTjR6c0tDOXFVZ1pqSHhzREFzSXNJck5oTG9JVk8r?=
 =?iso-2022-jp?B?eGdPcFB4TGt2T2I0OXdEMzBPczVSVWYxazFXNWxmTUNvZHl5QldnZTU0?=
 =?iso-2022-jp?B?ZVpNYU5IOXN5ZCtodjFod05YSVltM2c2T1NxZUFqM2pwUWcxOWlHdmlr?=
 =?iso-2022-jp?B?ak9KSDYxalJlYWw2U3p4Wk1zUU9QWU1Vd0VwaWhYTmREdzFTOWEwZzR4?=
 =?iso-2022-jp?B?aDRrYmlOcVNndHNKTXNYaDcwM2hNVERRLzYxZndtWmp3a2taeWZlOFBl?=
 =?iso-2022-jp?B?cmN0Rld6dm41ODhYV2xqRFBwN3NoLzJFSk1wclVTdVdhTHZKVTNwNjhx?=
 =?iso-2022-jp?B?cjhrWlFRUlZIcU5FSUc5OTYwUFBDWmVOdGFxNFlIOHYxOFBEWHJCSGkw?=
 =?iso-2022-jp?B?YnJwbnNFeGdvbzJQbXRobTFvS1NyVFpJYzVuK0xkME1kQWpFSCtnRlB5?=
 =?iso-2022-jp?B?djZVWVBEWndybUNNek40M0wvdW5vMDNiY2llN2ozbFJLNmRLMUVmRHcy?=
 =?iso-2022-jp?B?R0I3OFZ3ZitXU0N1b1RpblEzeXF2REZFWXFiRzNjbjVRd1B5NDEzenc4?=
 =?iso-2022-jp?B?NENEMnQwMzF3SS9tMjdLWkJZZVpjd3dHenI4S2RYZXgyRm9KMXVQSExF?=
 =?iso-2022-jp?B?cnJMZVA5aVNZUlRYQmpzeFhia3hoWENneStyNU1BdlFqUk51cE41d0t6?=
 =?iso-2022-jp?B?aXJobCtTRjdiMC9EY3h1Qys3MFV3WlpOckxYQXVraXhmRE9VQlVjSG1t?=
 =?iso-2022-jp?B?ZzlHVjJzd1V6ZjU1RVdXd0ZBYXY5QlU0VDN5cVV5ajhybDY2NUljaWRw?=
 =?iso-2022-jp?B?aE0vRFNwbUpMS1gvQ3RDT2k1bXpUczFDYTlUbmxIUkVhZkM1RmFoZStM?=
 =?iso-2022-jp?B?QXF6MlNGZjZNYVc1SDIwdDc5Mk56MFFrWnRrclMzNU5JOVo0TE16R1VZ?=
 =?iso-2022-jp?B?Z2Z6cUR0YnlmSlc5L09SZ1l5U0xnZEpma25ROTZwTVczd0k2NzRRb1pw?=
 =?iso-2022-jp?B?RWI4SzVDSWNNT0gxaTl6YXNxYzlCT21ML1VuZ0d1T1dRZHdLMTg3SmM3?=
 =?iso-2022-jp?B?M2dJY2k5RXUxT3FiN3hzZmViRmEydU8zby9sKytiZlF6RU9MK0k5NUI4?=
 =?iso-2022-jp?B?TUVFS0EvaXBFSTZpVW1lNHJBeS9IU20zT1JENnB1OTIyL01jd3JIUlZX?=
 =?iso-2022-jp?B?Y09YZjZib1hna25vQTdhT0hiOGxkaVRNMXU4Zm9Cd0szZzlCS1JSdW5y?=
 =?iso-2022-jp?B?NXNvWFZpOG5TVWRFRnVpMXR0UUxmNUtMZmppaERNLzVBR1Z6QlR3MlRO?=
 =?iso-2022-jp?B?VXp4U0NQOXNicWlvSDFSNW92TU1abkppbkdVM1J5VFprVjA1SFY2NmRu?=
 =?iso-2022-jp?B?RTlkbWJ2eWpSeUZya0s3dy9FaTdVcE83bHREa3ZkZVBtTnNiTVFRMXdO?=
 =?iso-2022-jp?B?bFliMFZYaFloQm94QmEzRHNneVVBVXBnSEVVbzVNTUlmNUN0NTZ4TC9k?=
 =?iso-2022-jp?B?TUovM3dRTTczNElKc0s0eDc3dzFDR3B2OVNTZUZ1UklEdjdrS2J5YWFm?=
 =?iso-2022-jp?B?UDRJREYw?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4e008f22-950a-42a3-b6a9-08d9afe996c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 08:00:04.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 7as+plkN5u1aVton3VTw0wORL5UTvwTzZHrkytWVyF2J35DHtAV9J74eFfdRDYTqgUc0/Xfog47L2IJnvnAiaVS7X8doTNsRjSTSYKhEvKPKCjguLwjAc5ZqprdZbkWO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5259
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 08:00:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7012

Hi,

> > CVE-2021-4001: bpf: Fix toctou on read-only map''s constant scalar trac=
king
> >
> > CVSS v3 score is not provided.
> >
> > This bug was introduced in 5.5-rc1 and fixed in 5.16-rc2.  Patch for 5.=
15 is in stable-rt tree. Patch for 5.4(https://lore.kernel.org/stable/16375=
7721744154@kroah.com/) and 5.10(https://lore.kernel.org/stable/163757721518=
6161@kroah.com/) are failed to apply. However, this bug was introduced in 5=
.5-rc1 so 5.4 can be ignored?
> > Fixed status
> >
> > mainline: [353050be4c19e102178ccc05988101887c25ae53]
> >
>
> I attached a patch for 5.10.

Thanks, LGTM.
I think it would be better to add the comment of the conflict fixing.
e.g. https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi=
t/?h=3Dlinux-5.10.y&id=3D1ada86999dc84b852fcc32962f4002e939f4beb7

Best regards,
  Nobuhiro

________________________________________
=1B$B:9=3DP?M=1B(B: cip-dev@lists.cip-project.org <cip-dev@lists.cip-projec=
t.org> =1B$B$,=1B(B Masami Ichikawa <masami.ichikawa@miraclelinux.com> =1B$=
B$NBeM}$GAw?.=1B(B
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B11=1B$B7n=1B(B25=1B$BF|=1B(B 14:16
=1B$B08@h=1B(B: cip-dev@lists.cip-project.org
=1B$B7oL>=1B(B: Re: [cip-dev] New CVE entries in this week

Hi !

On Thu, Nov 25, 2021 at 11:42 AM Masami Ichikawa via
lists.cip-project.org
<masami.ichikawa=3Dmiraclelinux.com@lists.cip-project.org> wrote:
>
> Hi !
>
> It's this week's CVE report.
>
> This week reported two new CVEs.
>
> * New CVEs
>
> CVE-2021-33098: Improper input validation in the Intel(R) Ethernet ixgbe =
driver for Linux before version 3.17.3 may allow an authenticated user to p=
otentially enable denial of service via local access.
>
> CVSS v3 score is 5.5 MEDIUM.
>
> Intel released fixed version of driver kit. Not sure this CVE affects mai=
nline's source code.
>
> Fixed status
>
> Intel released fixed version of driver kit.
>
> CVE-2021-4001: bpf: Fix toctou on read-only map''s constant scalar tracki=
ng
>
> CVSS v3 score is not provided.
>
> This bug was introduced in 5.5-rc1 and fixed in 5.16-rc2.  Patch for 5.15=
 is in stable-rt tree. Patch for 5.4(https://lore.kernel.org/stable/1637577=
21744154@kroah.com/) and 5.10(https://lore.kernel.org/stable/16375772151861=
61@kroah.com/) are failed to apply. However, this bug was introduced in 5.5=
-rc1 so 5.4 can be ignored?
> Fixed status
>
> mainline: [353050be4c19e102178ccc05988101887c25ae53]
>

I attached a patch for 5.10.

> * Updated CVEs
>
> CVE-2021-3640: UAF in sco_send_frame function
>
> 5.10 and 5.15 are fixed this week.
>
> Fixed status
>
> mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
> stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
> stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
> stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
> stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]
>
> CVE-2021-43975: atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc_w=
ait
>
> The mainline kernel was fixed in 5.16-rc2.
>
> Fixed status
>
> mainline: [b922f622592af76b57cbc566eaeccda0b31a3496]
>
> Currently tracking CVEs
>
> CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
> Bluetooth Core Specifications 4.0 through 5.2
>
> There is no fix information.
>
> CVE-2020-26555: BR/EDR pin code pairing broken
>
> No fix information
>
> CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning
>
> No fix information.
>
> CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
> Provisioning Leads to MITM
>
> No fix information.
>
> CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning
>
> No fix information.
>
> CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioni=
ng
>
> No fix information.
>
> Regards,
>
> --
> Masami Ichikawa
> Cybertrust Japan Co., Ltd.
>
> Email :masami.ichikawa@cybertrust.co.jp
>           :masami.ichikawa@miraclelinux.com
>
>
>

Regards,

--
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


