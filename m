Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43100C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 15:11:14 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.59])
 by mx.groups.io with SMTP id smtpd.web10.10716.1702307463566092542
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 07:11:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WBJqO8Mr;
 spf=pass (domain: siemens.com, ip: 40.107.8.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REexj/soLR67CiXUM9HmqKi/b2ErnpY0Plff+h/i6A60EwvOQs7KB7JO+Q1US8NxeV++DlqpWT8gv34WRcdRsLJpgbQdw/IgJCIK4hYui+hBSQcMkCQ7CQqTi/xkuZ8aFH+ZEUTcn8YDiebr+x1QSzM6m7sjeiqqW9jbLVua8q+CVYJO3PlTmDt8BxFZ2cYnkBwh1R0ytu4jjnqv5BYwcZVxWA7RpKG6Zz2z4xbFfcDpl7c7kAmhUp3/TxbI860mPdombR9I+ZRNJiMqopJwEWEn6Z14M9wEhDjegEfhiltPGZ5Ewgws2DA1Jeo9XQG7zFUMDaYB6qBvtqhrUV4UIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp7CSY7X/PcC0rGLlvxSEg1yeyBeKhtuoIn+C8DD0Js=;
 b=U9lDcHL2y9OS/f07mc2VhuCzC7f7T6QsktiIBGBIivtJuqwW1bA/K32SZn/0h+Vzf0OXGGWASddb3O7Q5izB9qOf26Ks4UzGIH/X3qvNak5+dX/bFAMgRyBm3PuOefxQkZxjFlu6hE+MDUnlOK0xsj8nh0xmNZImSHAB9XS/UoUsAwpsTUOAL/9sqNVJqtF9IArLK/o8sGRqOlWm6TldwAv7zdODB5l1Hgem2RfSFIq8peHPdXNyAKIzswSkM8rMaFrFk/r8PWSSEytDp5KxC8KSFDfrX/ll3GWH6VZEbvqt8EAJ8nGxgq+MGGUy/fWuwIZSzHsV1AnOasj8OtEmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp7CSY7X/PcC0rGLlvxSEg1yeyBeKhtuoIn+C8DD0Js=;
 b=WBJqO8Mr47ZmeKI11Ber48EKShXHcaSvtuSbTkkbbeRBOsvzPrzc5vSJO3uR/mh/TRZpbus9KGjIzDPAT0B+TDuXQyrZTDkVZ2t8j8sAvNrYMztpSq9ki1rDRVXJzFBpwBasazDkULdUhsFABEg4hV0xCLDVjHpy5ucPRtQRjnfB8F+olr3Onl64p08Hb8cEqlK7OMBeCG+ZlY3ieCy0HFMdzjeNSXJZZk4yqSGmW/hqyj+uJLLxSNoAg/15J06uWtNQZKISZ1BWiU2/dN3s1Q3bkNtoQn5Xi2xl4ipaLQgfPP+ZIXbFCmKEcW8FFKdunntTZFTo0v8oIgxT8GpfgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB8133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 15:11:00 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 15:11:00 +0000
Message-ID: <7168196b-4084-475a-9714-ced432b72caa@siemens.com>
Date: Mon, 11 Dec 2023 16:10:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 0/3] Add Bootloader to Update
 binary
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <570fc651-6525-4273-ad9a-aeef4737272c@siemens.com>
 <952cf6cf-65a3-4e53-ba25-01afe312452c@siemens.com>
 <d965d3fd-9e7a-4c14-90fd-a2f71cbe5ae2@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <d965d3fd-9e7a-4c14-90fd-a2f71cbe5ae2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:52::23) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 450e2fc9-b149-4ac4-b973-08dbfa5b622c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hjT4qNLE1SJSWUFtw4qWMKOjsv/z2bgiWW2PCO4qwIjRtCveMTjN2E45csFp03/Qe9ttXswDTQ5tcTS/Lsou7GEA3/s0s3jF9IhErwqSpAkMxfkup2t5QFmkmtU/IgB7BI0h3mgjLjODgvo5fL/AuAxBGX+xNtc0YHBXlCliKK3p+VBbIy7OIsCtnM2i+02gnm5CzZ2IHH0Bmj0F+i7cNGfnArJUz6QQcdcKnATqtrnRtYDrjoY7C9B7TpLaFXC0UMudDwUzYeY8kohdRitMbQi9kGz0qVNOO3bOY5qEGqoUryfOOMtQGU7tTNk4rzNItYxA/YR1gzzj6PwWsgI7Dw+gcLXkOT22IWdfbhQJppjTeNJY5h5IRK8L7B+ifMFbmMvIPQt7ciZyW2EgUuq41ZwX4p/BGlsfvF5y2+PrVl8RPWUnNldLaLKCku99XB0+lrqZpSloLzqM3g/nqr20FUVqZ8DhjS45jpitkXBbdJy1IAGeBlvHSZgN7CPcLkWhJn24E8eAJRLP5JkU4a/KnDCw+tY9fY12aom9qCMyJHM3gC/7bzaL+gL4kLa7d6gor4fBhiopLp9Wko/5+dSt8p8QC9WCndTTsieU8b4j4v70U5cO4+aTm3B/CGalmIxEzs3BtxqBkgyp4a87eymr1g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2906002)(478600001)(41300700001)(31686004)(82960400001)(66556008)(66476007)(6486002)(66946007)(15650500001)(316002)(38100700002)(6666004)(86362001)(31696002)(8936002)(8676002)(53546011)(6506007)(6512007)(36756003)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WIuC4auWW7ThMiiFvTaoClvdKmB8Zg2YNCVdLRqPoKY//ppNc5pnh+vSpYFo?=
 =?us-ascii?Q?78jwyP+++hO+EWZiHp0JYE8foBe1zjYR1tv8oTwrffUyGa1z+zN7UBAFYhtN?=
 =?us-ascii?Q?fwlqfXi7MlbFq+i0N3pgOzNpGYe9ts93pZd0QQEE8pGvaiHEBl/vpsG46gMf?=
 =?us-ascii?Q?Nr3VvdgAwUqlM6PtFM+FnZLNmWM3cJK4vuyengZMY5WEwINEeNHh1BCsRrJo?=
 =?us-ascii?Q?WhNdTD5HCUujgpryNtWg3PdszXL5QMZMf5wf7J75un/C2PbEnUPDLTSJ/v23?=
 =?us-ascii?Q?2z1baGnScwBoguutDQ7W1mzFyMYgg5T3XnUZn2PtT+EQcKRC7flSZgufEiPm?=
 =?us-ascii?Q?/idvODzPY04G8kAytA4IMTnGlbwejFelXHlZI6HvujaQDQp5isYVK5oj2x0U?=
 =?us-ascii?Q?jV9VQPL7W7QHdTtkeoG38s5s3oNMy+oMh11sxKtms/k9nLO1mNNbMxLsCPxY?=
 =?us-ascii?Q?gIVpuL3bUaW6y6ELwPwbDast19b7kvc5F0HH1DsMYAzSI3FXTlaVEfwg4p6n?=
 =?us-ascii?Q?DvpZSN+DmkS1TPU/hjyvGiL1Rtk5pNwPuCnwjXnPUHX/Dug+/20XtaE/tI1p?=
 =?us-ascii?Q?Z6OesiPSloFGz2iOy8XHsqp+cIzeT3+WdeybJEO+vasw6cPagpC9qA4fOdA0?=
 =?us-ascii?Q?QuRgUqsy3uzjuaRlwJKmy/IjlPVTQl/h7w6iuUPaqiQsTcYavHcBZLkEKZQa?=
 =?us-ascii?Q?puc3lbZNdqIVBdQ8684r7K/3NoIvztNsEQpWGUZS0bmPWHNjWccP6wq82Vol?=
 =?us-ascii?Q?AZEvxszXzTRIk5Up6jJykYU1sjJcdC9iYpVs5EYYcAptOzpJFtJzRYZJ5Xj+?=
 =?us-ascii?Q?bMe/Qv90r2IQ+NUldz5hAxQFaWFgMc/wK73Ki/meRvqSiM//LbXjTbkTdPOX?=
 =?us-ascii?Q?8Jq+lwaRyOaf871rt/kmWZq4KC+U5oXu0AA0Zjf/nDUcKt7pnwv+ut0NzeER?=
 =?us-ascii?Q?RoYhx0l70Pj4HZHwWZdzBSZNflEDsrQTetmX89QnZWjX2UWQR0npoh+t5AiQ?=
 =?us-ascii?Q?9tAHagBhSGA1e5pNrV1tp3dES7md+xI/p32EqQBdb3iMimjAU4m2+5Gqec3J?=
 =?us-ascii?Q?uG70PF1TDAm7vvIKzPMGtsM9M2ug9dUGBwa+Dn/XnQ59IRpTttPIm9YttyEi?=
 =?us-ascii?Q?COtXInbml7SYWWx1ojHt2n7q9W35IOp4BF+4W9OzraopnLLx5cctpAULANT7?=
 =?us-ascii?Q?VXRbKpEiTmZ6PtwPIE4yVsf4xohgXTCyp9rp3x1JlQK1naPEesCVf9YlZPjS?=
 =?us-ascii?Q?ls8kaDYFg6sA0mVOBzthZBY9mjHP137l2F5JW/KHorUmUHaSRP/HAhnK1Vl1?=
 =?us-ascii?Q?30mfHnXp57N53doO2G44bLd5egt09Gc6cCEk0j5W/J45v6Pf36rJygIQm4A2?=
 =?us-ascii?Q?VeG5SB47kAou+LmSl6MuK5/I4mqY3eF2MENbf3uOz6fmTWdlQ/onltxY1KiC?=
 =?us-ascii?Q?Ww3jwMzONpij5zDtzf1AC5TCdtJJ8sCRJ5VDWIMr7KGWrISB3QiPc3TTuRuu?=
 =?us-ascii?Q?Ij28G/9LfhNsssvb+FTIlrjbWJerFWp0ytva6kqGW7TscVw4uQ/Y4uv/UWhx?=
 =?us-ascii?Q?8q5RVgryEi0ckOdNIZUaFKy9ztUBqbqHwmvQXErSNTi5Jxeffu3xh6OePbwZ?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450e2fc9-b149-4ac4-b973-08dbfa5b622c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 15:11:00.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wAJiWgpKYywx9BTiJrbqXXqBPdq8sC5QtO34pybkTrLd3ZmJi+Xa8JsUP3N/B4vohh90xfjvdwWgcPsiCYYPrOh+LkgTeisuzSlPAJnS58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8133
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 15:11:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14033



On 12/11/23 16:00, Jan Kiszka wrote:
> On 11.12.23 15:13, Gylstorff Quirin wrote:
>>
>>
>> On 12/11/23 14:46, Jan Kiszka wrote:
>>> On 11.12.23 13:19, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This series adds the, possible signed, efibootguard binaries to the
>>>> deploy dir
>>>> and adds them to swu file and sw-description to update the bootloader.
>>>>
>>>> The new entry contains following information:
>>>> {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi=
lename =3D "{efi_boot_loader_file}";
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
th =3D "EFI/BOOT/{efi_boot_loader_file}";
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
vice =3D "{efi_boot_device}";
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi=
lesystem =3D "vfat";
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sh=
a256 =3D "{efi_boot_loader_file}-sha256";
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
operties: {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic-install =3D true;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> Changes v2:
>>>>  =C2=A0 - The efibootguard file is only added if the new variable
>>>> `SWU_EBG_UPDATE` equals `1`
>>>
>>> What about only updating EBG, rather than always bundling it with a
>>> rootfs & friends?
>>>
>>
>> Currently this would require a separate sw-description.
>>
>> I am thinking about rewriting it with using libconf (python3-libconf in
>> Debian) to generate the sw-description. This would allow that use case
>> and other more easily.
>=20
> BTW, will this series already work as-is in QEMU? Because the target
> partition is not mounted normally. SWUpdate will do that for us, right?

The series will work as-is in QEMU. QEMU was my main test environment.
Yes SWUpdate will mount the device for use.

Quirin

>=20
> Jan
>=20

