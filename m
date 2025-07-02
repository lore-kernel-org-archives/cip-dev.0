Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1B8C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 07:04:22 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.55])
 by mx.groups.io with SMTP id smtpd.web10.17774.1751439861468203777
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 00:04:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZmxMhH41;
 spf=pass (domain: siemens.com, ip: 52.101.65.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB/thTCZZxf/r6S/1Os8SFrGGtKvEz8L2WaHtoWUA/OaxhpN5iSVUqA9Z3oBkiGaC4fhG2rQNzOR9txeS9uBE2FnB/gsEuyIgunA1ssSoGHzdFGkD+6Ph9Av9zQItv3drVs9naA02n1ouXTWG3l7iNVRIbXPs7xqjkhIP8BNMVhRaNmQv6ftRpLg1UhbvC8NOTIJ3vfuwY5D8+nyOWM+a8hsHUtptp/k41vZCwNe/IEHT51OAxqR46gtwIsf7l6cIuICz1eMgcOK3lLBb4g/dopsSpmBnqSByLp+FtY9KQL5Lm5/m+hVNpA+336Cd4wRsRx2zwncVSILqEn/sVrlug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuDTg8M6klcJj5Q15DFVnfEjs51ct4XMDcA7n4jG9FU=;
 b=J4R0ewEef3xRecOyAxm+0LSiCOfaT1UP22c5MxZooEy14OgcXjYqTig2TmNZUneTyygSQnTq8/NqHswfhelvvTxHJlhgoWsrj/Lq9w3Gx9HMaBZTqIt/cn2qo0J3YuABi/kPqO2fCYg6e3EDxKz5iU+kR7d591T4Y1Y/rvC3v07ELrCjMm72IHsRa/NpVKoPxVT1XTQ/eQbQIEJDbwNqKYg0DqH1iWJuSu4U+M1sGLPwJWonRrR8ZlU1YParLXCgX1wagEZbkaP7CZ6o9KXp0HMiyHbrKVy1kKlqwa5JmNe8Omu+Q47bmO/vab43nV9k9TPr2tZOKrT8+/pAny24Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuDTg8M6klcJj5Q15DFVnfEjs51ct4XMDcA7n4jG9FU=;
 b=ZmxMhH415ADuCIUzrJjbOYtUTUY4bpbjNAjnQUwV52NBV3ul0gBmSqfA9liFXPRcwM76dG3HumleC/8Fd7xz9m9OUx+OB9Tij8pP5J0OqQAEWegQy+g6BMUNWg8Wusi9Qa1NAv829tw/KmCij1INeCCje7koW6n03ret6k2EKl7MfxtPPJcG3Ui7hbLk2pDXJ+jKYTM5v8lwnuxEI2qlQMalQtsZSjxCgxQgvBW551G/AY2wUc++CN/jd9Pt5iZNoCGNOiMnKQv1CIkvzKQXXuOePGQNdgjRn2ATCKJNxdR6FrOHTnxHWr2Fvn2A7YBl/PmmolnmtbSOv8QSLq+8lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:606::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 07:04:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:04:17 +0000
Message-ID: <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
Date: Wed, 2 Jul 2025 09:04:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: LAVA: Support ROOTFS dm-verity corruption detection case.
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: f09edcf9-6dce-489e-a77b-08ddb936a901
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TnhLWExNLzlJK3dNWWx6cHhBWXNoV3ZLOUNHTXpIdTFGVVBScFdjZ3ZsL0VB?=
 =?utf-8?B?RDhYcGlESWxBdlZMWVB5ajVSeW1qS01xM21OcEpLTGwxL3FnZ1AxbmlPaFdK?=
 =?utf-8?B?eUJGR2dWMUFlZ3F5U2xkQ2pFcFJpVFg3VEdjOTJOeWRHaDFJN2xvRytVUmox?=
 =?utf-8?B?ZitjOVhoTEgxZ09zY3N1ZTZPWHhtUjNjZmFoQTh0R253azU0ZFo1RUdZb01w?=
 =?utf-8?B?S3FNUTVGdSttcGRaM0RPTHhtZXBtZHhpd2dpbjBlOS9Eczd5Ty9GQ0ltR2pq?=
 =?utf-8?B?NzRYMzZLS0lNa0d0NFdobzM3TTJlREtRM2NYRGRJMkROWllydHlpUWtVZlRF?=
 =?utf-8?B?ZUF5ZmJPdHp2SG94cE9UekU0QzFkM2p4dXRLT2srdG9oOTI5NFEvb05hdDVE?=
 =?utf-8?B?MS9DT2ZnNnhkWEI4ak00R2k5Tk16WWJ0U1BiaUlFRnU2Tyt6U1RpVGhnUERB?=
 =?utf-8?B?NGx4WjBZUTVYUjBCbWp0UjVtWUZZUWJnakpWbm9HNWlHRzhGcDFGN0VaeFRN?=
 =?utf-8?B?ajduMjNrVDdzOWxWeTArWStLazg4WU9JMklvNzVSMjRyYU15aFR5aytTWFU5?=
 =?utf-8?B?bXhlMVZEdjVHNUp4dTNuemJhOGhrM3lZbWMyb05kajhlSlVsWjB5ekltWEVr?=
 =?utf-8?B?SmlDVzlpYVpMRy9vbHlnL1JpN0xLTWVmNUJhSW96dDJUc2hXTTg5NHpOWE5p?=
 =?utf-8?B?OVQrODNieG8wQjRPYWM0bEpGUjZpMnBDaGFkMXFkZG9pMC9TWm5qbUNNMmtS?=
 =?utf-8?B?cmlaOC91Ry9SWEJLZEFqeUFMZEFlWVhTOWZ3Qkw5dzNHazVmQm0yK2MzWXI3?=
 =?utf-8?B?WUxiQTJmZ2s0ZEF2dzdQSnMydFU3SzNWRUxKMnYrUG9CalNDVTBCT3VKOFVj?=
 =?utf-8?B?YlNLSUwrc2pjUWg3WXBtL3U4UTZaeCtrbG1uSU1ZT0ErSGgxd2ljQXlsUDNX?=
 =?utf-8?B?amRYRXhNRkkwQnZCdkxmOVZtdWExZUNGMTlhRlp6T3lBWjRQSXpLOHNDbDJU?=
 =?utf-8?B?eXlEMm5ySWdsYjZxV3hRL0xrdkxWQnpKVFN2ekNwUVc5bTZSbEI2OGpzN3JR?=
 =?utf-8?B?cU9YaDN3K2NMMm9vd1RjZGlGcWtxUlZVTXM1Q3Z3Smd2WmhWTURnZjN3YWM4?=
 =?utf-8?B?MENHVzBrV29aR0RHNnVDR0QySjlaLyswb3RMYkVTbDBDWU8rMjFXVkNTQTRW?=
 =?utf-8?B?Z3gxc3FFa0xQYm9aWC9xbkxtcDV1b1cvd0c0bjIrSndNRm1laXJ2d1dNaWl6?=
 =?utf-8?B?VzdOMTdGMlJkcG5sY3RpdmMrTjYzL3FwSGFWSXk2MytQdUYxY3J5SkdwR1dO?=
 =?utf-8?B?ZjZBYTVSdmcrSG5GeWxmbHZ6VDRINmV6MHNCVFd0em9ja1dVZmp4MU1jMDhL?=
 =?utf-8?B?NG9UVHNWRnJubGVGQXdTNUYvdGppU3lROUNGSmtXTWRWN2RyNlAwb1RCWUEx?=
 =?utf-8?B?bENOdkhKRjhzWmNmTUVKRkVIYVpHMVZyZFFVcU1saW5CR292cTNNeUo5UVNi?=
 =?utf-8?B?QUsyeTU0OHFvWnltMmZNWW9Tb0lRZFpBd0xQQm43YisyRzlVMnlRTUpVUVdI?=
 =?utf-8?B?aVBZRElkQ0dOWVVTWlZxNXBwMnR6WEcycnJXWVg2MUdicGxSL0pzQllUS1Nr?=
 =?utf-8?B?dHpHSHN6RzcwN2Y4eHlzQzl6MWloVWsxblg4a0YvdEVROHVSNENmNnYzT0RC?=
 =?utf-8?B?aG1tM3dmZzUvaDZWZGZZcFJScHA3UlRVVW1MdDErTlB1c0NaOE9PTEx0QVJV?=
 =?utf-8?B?ZzBKVTRJbXFBYStDYnk4aXQ4bkJsdU9keG5nNUhkZkNLdEtYS09lbUt2U08z?=
 =?utf-8?Q?ix/6e+UOqCFpKe46q6voS7qhqtHiNiYRXR4u0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ck1scG0zY2ozaDZpV3pmOW5ML2hrTlVXRFZaM2hBR2ZycU13RnM1S3pKTmdP?=
 =?utf-8?B?TS92WERGSnY0ektwaTBBOERyVEZqK0h6TEhIaU1wSnhUOW9naDl2U1ZvNGlW?=
 =?utf-8?B?S095ZldXdVJNa0hadzF6MXh2bzVNWW1naVpqRDlHNTcxRkJRQ2F1dzB5YkN1?=
 =?utf-8?B?NTE2a1VUeXl2SE1DcTU4ZHliS09BTDF6U1FjTEFLbDNRbkdTTjdlQ0xhcm5a?=
 =?utf-8?B?TU9pZnN2ZFlDUDJPdVY4N1hhbThjMkxBa1RNWXdJYmRPYi8wL1lWNjJhbE9L?=
 =?utf-8?B?bGZwRktnaXNiaGxaV0ZLbkJLaFh5V3NZN2dhWld2MUpFQmFncmpkbHcwVlJi?=
 =?utf-8?B?TkFkc1Y2dmJOcnEwb1g0RzBRVVU4V2RzeUc4VWc4N2tTMzVQWVU2ckc1YjRF?=
 =?utf-8?B?cEtqWHBsZGN4Z1dNQVRPeUFLSlF0cEVocTBiakpRdjJ6VnZZV1N0SGZnVnVO?=
 =?utf-8?B?Z05QMDk1c1F2VUJYeHN2UDZ5aDM1RW5Ua2QwNmhKV0NLQ0VUbFJzOFhCM0lG?=
 =?utf-8?B?NmZVemR1QWFUZ3lKakFHUENDWlJrakY0UTRMQ2tkZWxRVFptVThoQ1VRYklT?=
 =?utf-8?B?MHJOUWdxYnA5eW8zSmVGM2EzNmI1TjNRTEpoSU9ncDZGWW1TTXBTcEk0SWNa?=
 =?utf-8?B?T0JiMWVFaVpZK3FNM2tBNDRMN2V3UWxxOUVZbllWNnplOENzOVVyZ211Kytm?=
 =?utf-8?B?K0Z1czVldEpJYWRVVysweDNhVFJya3hPaFBOY2toOHI2R0tBOFNEK1J6YzBH?=
 =?utf-8?B?dUk3ZkIwTHRIVCtDM3B3bmVDazNjbE13TDRQdjFiMDI2ejZRRFZUNjYwOGla?=
 =?utf-8?B?RTh4T3JOcHc5VTArS0xERzNYQml2MnlBdDd0bGRkajJzVkR1R0o4UC9QWmhq?=
 =?utf-8?B?aGlKWGRmNDErdlRib2VmQnlBYUpaVHhjV2U3ZXlTSG9SU2ZjQ2Y4MDZSWmY2?=
 =?utf-8?B?TVlGYk1CamhldkVVSmtsa1J5UUdIK1RqM1djRGZ2QmcwaEs0VGx6NkE3OE9l?=
 =?utf-8?B?YUozQ0ZVVFdlRk5VdXBuM3Ixb2xRb3ZnRG05SDhud2x2VC9aSVZCK2Rhc2ow?=
 =?utf-8?B?MllaQUFKOUtRRkQ1RVBYT3RMYml1c0dBSVphVTZUcVpEYXVHWjhtb2RNYnFB?=
 =?utf-8?B?NklmM0VGK0ZyZGZYdkxzL2t3YkhxUnpEcjA3RnZnSVZzZGpWODFFeVVnZHJM?=
 =?utf-8?B?Y3JrbXJjQms3RVJWbEE5MU1tTktnM1NuYkRuSTFEZnhzZCtuRklsM0toaEJj?=
 =?utf-8?B?a1dqZXl2KzQ0TnROeGc3WGpSM3NTL0hLU1RjUTgydzB3alFoSUlQUFh6T1ZX?=
 =?utf-8?B?dkZwQzdzbCtoY1g5WFB1ZjhBdWovTlFPM092clNvWThoQ3RIQXdCelBrQ1FK?=
 =?utf-8?B?NEw0aUhLUStGZmRoQVE4RlFITzk4TXQ4bGttQWVtTHVXOGRCSDl6ekhFY0NM?=
 =?utf-8?B?OHdqcHE0WTBXUlZSajFLbitEamtTS0FhZmRzVWFwdzIxc1FTaGZycmJXTTNm?=
 =?utf-8?B?MWttcFIxaXBWNEtVN1FzM2sxcm0ycDNOS0tIUnlFYTFtcUNMZ2VsRTc1TzRs?=
 =?utf-8?B?bGJTOENzMzRJQW1nMkF2VGNkNWNvMHdUaGh3dEplNmM3S3pxM01kSkJoOHdE?=
 =?utf-8?B?d251V0hoRXlUdTZhbFpBUGdBcm9EN0FKQzZlWjIydlFKK3pCazIrVnVqK29V?=
 =?utf-8?B?UDQ5ZWcwRGtUSDV0dVFlQzgwNzFKeEUreUpNQ0YxY3RlZlJUNWJqTDVycU9O?=
 =?utf-8?B?UnV3UUlua0xwZ3NIc1Z0ei80cU00QXNkWkZWSDlYQVdTd0dEWWpRS1ZQY0ZX?=
 =?utf-8?B?cS85ODc1dFNjY0lKZkNCcUpKeHp6WHVFOWxRc1dMc1ROcEd3RzBzYXUybVBW?=
 =?utf-8?B?aG1Eczg2d24xdEF5TjRST0NodXVJMTk4aVBXb1BlZXFkb3VzS0xSYUNqTllo?=
 =?utf-8?B?VEtUQlUvSENEV283cEhMNy83Y2g0Q2hndCtaNTJUcG5rbG5rRjdaWDZrK0Q5?=
 =?utf-8?B?RVUwM1ZoenBaTFBEejVGZ3ROWTBOSlFrdEJpYm9xdkxrVWJUYXNFREpoY1pD?=
 =?utf-8?B?UGJzL2E0MEdqdG1CSFV6enA2U1VLMWp4MVRlSEJPdmRqZWNFYWt3cVRZNWNG?=
 =?utf-8?B?TVlFK2d2UTVIeUV1ZlVpZ0IrZTVycytUbnh2Rk1tRzh6ckd3cDQzbnlPQ283?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09edcf9-6dce-489e-a77b-08ddb936a901
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:04:17.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLaVyhJm1rapRhN/fLKBBGnW/iMtFoDZzLnmvAmZr4q9+gPRlNf3QAgyKbJ3tgpx6fU3+rNQO1RpKqdaXCVXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7346
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 07:04:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19278

On 02.07.25 08:57, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hello CIP-members,
> 
> This is regarding the negative test scenario support for secure boot in LAVA environment.
> There is test case to verify/detect the ROOTFS corruption in LAVA i.e basically dm-verity corruption.
> 
> The requirement is to modify/corrupt the .wic file in LAVA using postprocess action so that the secure boot will fail with dm-verity corrupted issue.
> 
> In LAVA, partition mount won't work as the LAVA docker container is running with non-privileged mode.
> When I created issue in LAVA repository [1], the maintainer suggested to use libguestfs to modify a disk image. I tried using it but unable to modify because of Read-only file system [2]
> 
> So, I tried using dd command to corrupt ROOTFS as below (write zeros to starting address of ROOTFS)
> $ dd if=/dev/zero of=cip-core-image-security-cip-core-bookworm-qemu-amd64.wic bs=1 seek=157286400 count=256
> 

Is that offset pointing into the rootfs partition?

> After the above change, the job failed with below error [3].
> "Could not find device  mapped to 'home' cannot be encrypted!
> Rebooting automatically due to panic= boot argument"

Are we also encrypting the rootfs? If so, then this is obviously expected.

Jan

> 
> So I'm not sure this is the expected behaviour for this case.
> if this is the expected behaviour then we can write the test definition accordingly in LAVA.
> 
> if you think this is not expected behaviour then please let us know if anyone has any idea on how to simulate the dm-verity corrupted scenario.
> 
> Any input on this is very helpful.
> 
> JFYI,
> In other cases eg. corrupt unified-kernel, the below command is used to corrupt the linux.efi file as below.
> $ guestfish --rw -a cip-core-image-security-cip-core-trixie-qemu-amd64.wic -m /dev/sda2 write /linux.efi "corrupt"
> 
> [1] https://gitlab.com/lava/lava/-/issues/671
> [2] https://lava.ciplatform.org/scheduler/job/1286826
> [3] https://lava.ciplatform.org/scheduler/job/1248737
> 
> Thanks & Regards
> Shivanand K
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

