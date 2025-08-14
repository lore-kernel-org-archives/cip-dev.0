Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E42CA0EDC
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 14:35:03 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.41])
 by mx.groups.io with SMTP id smtpd.web11.24119.1755182102418259160
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Aug 2025 07:35:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZCiXXCQO;
 spf=pass (domain: siemens.com, ip: 52.101.72.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSWDA6tNwux9VAsPAOVohKhvf73HbwK2zJnv5jU35Rg5NYSrmDjXy/qto1aN9ewHtobjtxxFMCdi4dMs6G12v4hxd5dfGKfj/vBjY6K6K02txCdqISjvKy9NkrNTMNH57IBmESkHOG883MF8Fmp+l77s7f4TeJRNK7P1QuPThXXw4qgbLHh0YrozP1CTOpIegIz7iY/U1TQmfdMgiB8lGf97Y9QZUq1MmWF+YUr/JTknHVT3AgZkqbgMyivnhKw2we25zgViuALlhe9KbZLBx4Hj7o2A0SgiLbCi0TfT4exRAROTQdqyeLjbDRxkzNrtFNRyQluuMoz+LEcKRMs+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV/gkgegzAZfoVUL0/hZ45gSr6EfDZrNFMIJXpkmQdg=;
 b=GocczAZ62xoldwKbynE9F/J+g27G4PLJPEEBC47Db2IkoUuGi/UOKH6Jj3J0KvU2bfXt1QwmC/YMKx29DOp2/Z5mG/xVeVBeRmgCP7ZmsVrXlGH9VcVqKZjFFs4Y2wFlldzeQhSjPAGnJIasFEvyhSBy4Lvlv12pBiSz48RxFDBF40Vhlwn2V/AyocZpZNAgbMhQHKnH/kc9jnnPsL2BbNwkbwJ72iNP8lUW5lT5fMpPt1Sd7P+Wd/ifI9gs+/ds9MowKaRGEqEKuM8Bkghdm4PBwQ2lpZzles/VKyGCHgF6cjZNnfvU7Vhdzw609Pl94TU1GXjyt7b3P4gUS1QZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV/gkgegzAZfoVUL0/hZ45gSr6EfDZrNFMIJXpkmQdg=;
 b=ZCiXXCQO1Mx+OQ5gzZtGFSTM297O5RJNuDyiraBVyNLi3FPz8/SZZCtdlgUuyrqetENzQ0GkOLMXEg0/584ylWC8mjJMIE2l5Yc2ubUCT8hG950PEBfs6uVMH0AXpoxUsysdLyZJyh+jfihRgUw434u+/RhWTt9237mtFtNGnVbcdfK7NLYKBcoo4INnpv3QfzXn2d7hbrbPKBNb5xio9F6LLXQKZEt8vj5kdBURc6w6mDt/k6P6bIivw7mccZa4L2FpQpKpjEfJjc9+Dj1GgyACkLSERN4wXtGr1YJnwpvlMeqOdkpLPYKcUm0gik8innqdg3iBastTNYcQNDiwvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB9299.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Thu, 14 Aug
 2025 14:34:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 14:34:59 +0000
Message-ID: <d4107b6d-c0f2-4424-80df-abd137c524f3@siemens.com>
Date: Thu, 14 Aug 2025 16:34:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Effective QEMU devices usage for testing in LAVA
To: Shivanand.Kunijadar@toshiba-tsip.com, chris.paterson2@renesas.com
CC: cip-dev@lists.cip-project.org, kazuhiro3.hayashi@toshiba.co.jp
References: <TY3PR01MB11075A93846FA70A1AEB01145C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075A93846FA70A1AEB01145C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH5P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB9299:EE_
X-MS-Office365-Filtering-Correlation-Id: 405c277e-dcd3-49f6-6ec7-08dddb3fbf26
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WLHhPZxT40WhctI+N5AoC+fV/3x6z3aehCV31wEvc872REA+++eZ+hTAenN4?=
 =?us-ascii?Q?Ig6Fv2yRO9e5+3pI42f+lbAr85VqporEr2UF0noN+D2r0nFoegLS+Tp0wINa?=
 =?us-ascii?Q?3x6Fzckwapk4oWCbGi/rztf++3Wev1VkCOgzxtE19P1C+V2G0VKtULZxLPy5?=
 =?us-ascii?Q?65d7Rn9z0Qs/C3zAldLT/TGb2xeiM+8GWtheuW5ukWwDsiBxq3gKOBwlyT53?=
 =?us-ascii?Q?C/CMXVnR5OqxkTaYeEAvfbeFyJcJxkBRC9sdedWQu5VAit46GRTNxtkxzEVf?=
 =?us-ascii?Q?wuo1KXZUhF/KPB5/s8Rocc3xKokKkTp6ui4KUIUG7a6kGr60P5++Wg3GOQtR?=
 =?us-ascii?Q?zzPaNG3aQfmQU3Me3cyoHAE47qkITvAAzoj2eX1GMHWCmky8WevsU6+pgExn?=
 =?us-ascii?Q?BVzuKeV1Bv6Ut0zbhqfhjINf3hnCL+Afy7BQl7KP9sSumZ2B/9OjYKhV6Q+3?=
 =?us-ascii?Q?Cn6VkpO+IcA/jth0briKEO1KhJvT+J55g/1ORV8cYXKkYg+wuKvmbpGU7SOp?=
 =?us-ascii?Q?2BCtcYrHI2x10uNno/1C2kDBPpWXZC60zZAFZUODGOYjdmHx4Ni//OeohWyo?=
 =?us-ascii?Q?BwYYhh9PbKIbdZcqmrhc+M8qzftyvIMu72I3jDbD8Eb2VczYy3DkTErTzNn6?=
 =?us-ascii?Q?vYu7DRGjHtzYSISm6hZjbDoQNFTq67hjWBkh1mQ6DMg1419SHDzjtI+wC9z4?=
 =?us-ascii?Q?aDZf1jwJsI5+QDM5Jua9HB5PPao8gYdhQ3ZDDGxd+oeYAxksF1RLbtsFgJQq?=
 =?us-ascii?Q?xxxkbzs5N+ur0c9RPEcwGkaJdlwVWUcoWfVNtuFIHAX1UMTp6XucWy0zdJNL?=
 =?us-ascii?Q?M4NdwmINzsgb0nn/CUgyF8rA1Jw9nQCZqMaL2iN6v/pnnyn6nPuzRoKL61H5?=
 =?us-ascii?Q?oLxWWaGF3e3zc4t8lJWylfjU8fX3J+2rJ1Gth0fiDYX2QCnAgN9NrvSlnwvS?=
 =?us-ascii?Q?t58V1+KteIWm/boNkmuzPZZjX2zcYUZTl1H1x4EuabBPfRq7T+vAvC7eVm/s?=
 =?us-ascii?Q?73rHsW18ojYWU4UQ5o+tEAiLrvjtxI8aHKCq7tPCkDX94XEUBsM+DlNIB8eV?=
 =?us-ascii?Q?b7RcWod/ZH+UmTX3Bg9Y56wWw6CE5SM+Mc7hVXDk/MLzlv0Lmez/8exZZEj7?=
 =?us-ascii?Q?FqFcGcA8b/pZBdcfse14Z25Lq06QEAx8mHIW2SA63X/5t/flboK0u1J0XT88?=
 =?us-ascii?Q?/cGd/jbsYl/Ll/a+92OwsnNI9K5Ar+XazhH/htTedPghCu6+wz1aSVF8vZSD?=
 =?us-ascii?Q?LuRqbOcnCoBFl93q2Db0Q1e9taec2+MSxetOrw7IiggBv10zGq0353ilct5P?=
 =?us-ascii?Q?kM8y9qTJplwYUxwZJgVxklRltz3JY6WW3xyhFGY75SJsoeEhsItuNyd7aXDU?=
 =?us-ascii?Q?/8vGa5c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KyxJjBxUSloAyd3STFm+IMGCpJhabqq5+RHPJD1Baj2xiZnnPKzBY3DyF8JM?=
 =?us-ascii?Q?baCbLe+pSbhy0hu+pXrqmKZumYpa0ZsxDxMzPGRykUiI4lkXWhKss1evyZF+?=
 =?us-ascii?Q?zjbTudejFK35jkahPvXhezNexC4UdLYL9cmimhow4TYmAr7Zm1/rcJJYPIv2?=
 =?us-ascii?Q?mr2NnFEd6KfL/T4MziShLa4rFZGTyr8TvhyjGK35xP9cg/WovhCdVjkOrT+z?=
 =?us-ascii?Q?iksv4ch0iPxK+GDPMpMSYQYrsJxjXrxEmV2by5FxXvcSaHaAyPVxmqBn4kLT?=
 =?us-ascii?Q?XyuxgUFh6V/Nrsh4HdnR++MIY0eYmLfU42oOUs4E0c1fKBHQw0lrWxd2APWi?=
 =?us-ascii?Q?AW+QIZ8fJtciPDih6pSHWMeZQ6MWqtBlhNtmbUzD2jaMhO1KmTENccKLtfg6?=
 =?us-ascii?Q?PfL7AdnTWDd/AZGUsIfnDTqtLDG4wr8KPvZiXKj5aqO2+FOJTL/vUjRtLZba?=
 =?us-ascii?Q?dxzFGN6mUkD70XgVBEB0RYa2S3U6gV/Lw9OVfaO1Xh2uPVbt0fdRjLaUVI0L?=
 =?us-ascii?Q?MhY+YInFK5kiehaG0hXuKYCTRT41VTcpm67bPboRqS+l/T+TgQje79EiwsO5?=
 =?us-ascii?Q?5s3jNGTLwhFY3SvlYdrBXQ6LTaFb0uLLSjt4U5a+i98O+VE7sFmzZ/faiFSW?=
 =?us-ascii?Q?3T4TKGMqpMQoQTYaMkPT2EBjSp9inXLxdoFaoMPGVyQ+Xa6q3kuJV1SSrMPp?=
 =?us-ascii?Q?ed9O/DZ2jEQ72AZJmHPSdxr5MIHQC3yTFbxn0Dgkgcj7q0DLhVQjkA8hzQDx?=
 =?us-ascii?Q?ACKuqhRSavjfDkF8Z1DJvsmSwx/Ag1ZpHeyrhWvgBRsvZJHNIowZ2OROrGWw?=
 =?us-ascii?Q?8WN8PptEaW8FQBv79VaBS1Pfe23rCHcyDEHyYzLiZvD1lDmplYrOYgRocQMr?=
 =?us-ascii?Q?qZpnnt7c6N2scCVl6ilhDvYFExu/hmN1EdBJPo6C/dZLuz8eJGlRZpD9L1e2?=
 =?us-ascii?Q?eGoNdcX2rdx4z6VWGCEu2iSZtfrFk3RbHebQmtcUjcUY5ibF833ph/kUVG4H?=
 =?us-ascii?Q?oWObPrR4h+PTBr+Xese73K6y7WR4W8g4aASxJfXTv8SYViYsT4dFp69eFN5S?=
 =?us-ascii?Q?hWnS7C/fWJuvsbapBcxUwHTNeqQKFFDxA0viwEfyKiVj+/T8M8hX/uQ3XJ75?=
 =?us-ascii?Q?QM944AzqVTdX+vru7DOgV66yMPH+It4jZfccnoT0HZGDSinHtYggfcV3sMuu?=
 =?us-ascii?Q?i2GTbCiRo7Z/RW7XTGGE/hFgbqvxFDku3fUbsIy3Gl5L4AW6O0p1tPfjlahc?=
 =?us-ascii?Q?L3rP+sDHrRUwZpoyfZJQ5aw7eebztVuEaqfyhus18KcaS7yjHYAo/mVHJhB3?=
 =?us-ascii?Q?GDWUC9b5h3EUtKtVnuOxl18n4YNtbqe6oAr+hmdIe5WtUtcK3yU+ZJJiPgJe?=
 =?us-ascii?Q?Tf2sujMjT3GKpVGLVRWxbfl6qcCDdElxcnZ6X4MqVq43p8kU144trPCS7WvW?=
 =?us-ascii?Q?yOeEBDLkLFQ2Lz1BpbJcpmNUXQ+Bws1IIK5lBKwOKCpnyLfn1+YHMWhPTZXd?=
 =?us-ascii?Q?hlM9o4sSYQ+FgBgAS8u9KXXgkEX0QSYI6RCdZw1/gQFb3VKBed4C1t/BTAVq?=
 =?us-ascii?Q?muq7EXb8Ai9G8cTE9OOE0MDf9vBgAgEoBtUtMVXcP+U5MWkTkd3/jEzLdw+q?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405c277e-dcd3-49f6-6ec7-08dddb3fbf26
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:34:59.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPINuD9YVj58FBkRCc5Jtj0zvMGQTdxqlhtYYGwoMfaAUJbQh3uMPO/2X5+FuUg9aqlziAeeFAHewC393Rb0yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9299
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 14:35:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19749

On 14.08.25 15:59, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hello Chris,
>=20
> Hope this message finds you well.
>=20
> As you may know, the CIP security images uses swtpm package for booting
> the devices on QEMU.
> we have added a separate tags to devices like =E2=80=9C*sw-update-testing=
,
> swtpm-jobs*=E2=80=9D.
> This makes the LAVA job specified with these tags will run only on the
> devices which are assigned with these tags.
>=20
> I had a look on the list of QEMU devices on the current LAVA lab, I
> observed there are many QEMU devices which are not assigned with these ta=
gs.
> Example:
> https://lava.ciplatform.org/scheduler/device/qemu-04 <https://
> lava.ciplatform.org/scheduler/device/qemu-04>
> https://lava.ciplatform.org/scheduler/device/qemu-board <https://
> lava.ciplatform.org/scheduler/device/qemu-board>
> https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
> <https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc>
> https://lava.ciplatform.org/scheduler/device/qemu-iwamatsu-01 <https://
> lava.ciplatform.org/scheduler/device/qemu-iwamatsu-01>
> https://lava.ciplatform.org/scheduler/device/qemu-patersonc-02 <https://
> lava.ciplatform.org/scheduler/device/qemu-patersonc-02>
> It restricts most of the CI jobs to use only the devices which are
> associated with these tags.
> So if we update the same tags for other QEMU devices which provides more
> number of devices to CI which will eventually *speeds up* CI pipeline
> execution.
>=20

Are all target devices already enabled to actually start with swtpm
attached? This may have to be addressed first.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

