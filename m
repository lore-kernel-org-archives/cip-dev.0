Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50ABFD8767
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 13:06:59 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75500.1773752813464790875
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 06:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G/+aQ4rJ;
 spf=pass (domain: siemens.com, ip: 40.107.159.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUDG+Ltn7kq68fTegTgt2tiJzK2zowpRd7LHkFU11E76fzmOBkysgPM5kbiVu3fJ7suiy8cKaOC0LnNd43E18na7tiRVAWbeqIObNAVoF8ooPUn6cbYz/yJAPBo3MfLoOjOqt4AShO2JsTFMdVW8mtCSeD0d/bHJ5EBQD0hGSTVXjkRtZLyDW4VNbMJwPNcLwY3typ1Q0NFG+94/85FTmuHcW7x7Dngcbb3mPe7bE/e58oc9DwMIK5I2x+MPE+mR5y+HsEbWZVrmcFRlpiPIaYZ+NdJZJOs/hzm4x3GsuRHTlVS/2ZZdhh5aLuDMxiMbw47gVQ5e1g03kCx5/qprew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4ePmRtddPK5iuqwhOyAzE4tI1R4eWQgdyNziuEaS6I=;
 b=zO7MUOvAmRUZH0cp9hyNSxR5alSc2nwSQYcfTJxajhN36E6m+07vdDel5iJBDvg1fSTwvkddNfy/sCz0zPsGyq6e9GB6cIWyLbjeV0g2TIqSRStfSgiI2GQlaWsL3uGIQ35O/bOCNyJuvxcXSIlicZoj3IpzMFYbx8VA1GBUOaKN5VDKKExOyA+3omgTwVXB2tgjsRWmXVCe4WQ9GL4pxnfAcA2uE8XHcwPzApttpr5KhFeDzwbJRH6jlHPsYnsin+Fhs+juqSAEObAm4WJCfnkBeEgMrkikxcF3Mek26Tuvv37/AYARmpODnVbilkgkkISCGfaaH93EaGQ0/oA4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4ePmRtddPK5iuqwhOyAzE4tI1R4eWQgdyNziuEaS6I=;
 b=G/+aQ4rJ4qf+dsSlcgUjGCKQ3Q/Y3whE5mqcL0zcUTRJ+gQYQofLpS41vD7xdn6JVlryHk3hpr493VyTOsthaawwU56Qm/fIcyXif3Xr8yB8p5BpNfpK/12a7W/DdXkCxYpZ25rBPAb7fm7ZXmLq6Kh3QBkW20ZR7QU845+0ONxtVglmANA5/JYbA5nxsNtaI0/AExUViFe+9jXLVyB86vU6e61POgsjEdEM5ECXTIP+C+UUfQoZ3wc5rn05O3gh7btuMo2p2ZRP2gMAFZAf3Si1e0MIjN9SKCmy+0D79A7wx0LcmphoVvmR9xtpnmqYXgrqtODNz+NmWARl5Rjwdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Tue, 17 Mar
 2026 13:06:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 13:06:46 +0000
Message-ID: <8bf879c6-88d5-448e-a0b5-861097f9860b@siemens.com>
Date: Tue, 17 Mar 2026 14:06:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] security-customizations: Fix mistyped pam
 configuration
Content-Language: en-US
Cc: "Berge, Matthijs ten" <M.tenBerge@awl.nl>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: c189c9a3-3fa7-4012-7a4d-08de84260b68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	od2UNriWYiaiVGU0BR3v/ihjASf9ziVN/5Egp4yMe4QcHacPRkp/pm+I5xfDz/vkcEttkv3ZYVJXCNjB8HViR2WJJTgrwJjgmMZDmb7PMm9DBhGWdUenkAG1bFxBLU6s+e6XOAop+bkCXh4QfY6wtwUQbNUqK6eSzty+M7gaZb9Gycr45a1BRdrugFDtv1ZIi0ZBuvW1hKhuVVCyEtQAf5kM1ilgYzz8DmkqPPsRiyhKH82NtwEo/xCcAyCKs3Gbad3Lj3v8veCjCSUUAJj1bZTTGSO5y+EtH5MnphXMTNSH0RPcBCGqYxXV5JGK5jmoeOK2izlyS6+x0JBmEmeHaxOr7eE7raeDBa5aENjKFw65qYQESFNhOR5LDVGFoVI6oAQqT+LL2x+Br/Og0mekzZmax3v/IcU3ZnHjxahCbFhpfQE8Oq8D2iWngzUjpMnJgGuXMuSguRAu9LngMKDZYf0mfJ4oaIWnpcYuEgkXQPm+uWaShN/bLfdjS+IMUnBqe0Tf2t8blydQ/XZkEs/IScTAQ9PS1bXzeQebyPdMK3OoXlgYlLuosRPwo9VVDp1npDQUgFxdClZLGJ5/8Nax86lw14V95VLtmBgDsQgGuTaIwSjGbu6TxwYAmooomgGTTeNAmC7vy020umIhEtcRxTMzlddhyYyzjlZRQ2DHnjm1GCZTDpGYFsfS/ZXzgZbMTEgbfAoKKkKTFBH6eQupYsVLypMuWAA8DFa+p98uNHQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVRMQzFkUHZjdzBsTUhnRUU3V2hLdDhNc0FhQ0FMUVZrbjZVMzFQeGtFWGlM?=
 =?utf-8?B?OE53TklRM0hSMFRkbDdNSHQ2OW5hMElMMDl3SlFQVTZnUy9rN1RHRmdBbHpN?=
 =?utf-8?B?K3RJNU5QZlM4WmlzeTM4ZSsvbll3WDJSNWVrdTMrQ1VYU1pSN05aUUgzTjNP?=
 =?utf-8?B?YUhsUXd3elBsZTFnUGFwZ1pFbWVNcXdBbngyZFJDa215aUpXdTRWcTZDZmNB?=
 =?utf-8?B?bEFsMFdsM0tQZ29tcGtDZUhLOGttRjNOS2RLTzAyRnBjVXdTaU9oL3hzNGNH?=
 =?utf-8?B?UmhTU29xMGl0TzdONkZOMDhDZEYzS3RhSFhZR1dzL1F1dTV1dHdkQmJHVGlQ?=
 =?utf-8?B?M25hTjdmYjZYWlprclEveGExWC90bGltQStsR2xhTHNTeithNG5hQWt6M0lO?=
 =?utf-8?B?TjJ3TzZMWlQwMVYrZG9wOHhTdDZkbkZJZFFpT1Mwcy9OOUN2dUQrSFhDZUZW?=
 =?utf-8?B?a2V5UmFBMWlxWm5oWWpiTE9RbFp5NmcrSk1hdUsyVGdQZTVzbXFrSDJ5UmVX?=
 =?utf-8?B?dzZCa0szOWtETmRxZ09PWnNrSFJWQkRKSVZmRUphcDNTUGRkN1pRMW81UnRQ?=
 =?utf-8?B?TE42Q09yWElJTjlpbVhKM3h3cENUaE8rcVZBaDVPV3lMdUp5REJIZGp5UDht?=
 =?utf-8?B?SEl6bUtzNXFJZForblNrU1RmYUtGcFcyT25EaktKTG11M0F5ZlVwcTJCNTRU?=
 =?utf-8?B?bHc0UTFYTlJBK2hzbnVQVmlra3EyRWM2cCtQZEpMcjN4YXJ6L1BNRzRYTHZz?=
 =?utf-8?B?dTA4bWQvNkdWMStmUStkcW5SUHgxcFJ3QXpPQnI1bmVUeFBNbHoveUhma1pD?=
 =?utf-8?B?VE0vK2dOSXFOQUNJdDNpZlU5a2JseXFXU2RVMGp0UGQ2ZFQwZzBqMUFXdnRm?=
 =?utf-8?B?SDE2ZFo2cktwbHJKVG1oNmErNU0wUUlaV2RHTk94emFQTDhTSnFhZTBiYWFY?=
 =?utf-8?B?S0xFaEN1emlNYlV1WUdjZ1FHUWdFTzdhSkxodmYxMlZIOWZ2dDlqdGprZEY3?=
 =?utf-8?B?N3puZFJxVk13RXp2M1o0ZWMxanhjTDN2azg2M21kRS96cG5ENzkxVWR0TWhX?=
 =?utf-8?B?V1F5b1UwM2pxb3N5UkJnb0FLZlNZMkowWkIvWVZYbm9nczlxY2p5U2dkK0lJ?=
 =?utf-8?B?YVhyU0htVTBLR2JHOVlReDlxdEU4c0ZOMDNrWGpsRVhtMHVzUjdjSUwxNW5Q?=
 =?utf-8?B?LzRnMEhzbkZ1ZkVOZjJkOGZDOFY1dkx6SWZacjFlUmlPbGg5VFdjcTlvbWpT?=
 =?utf-8?B?S0J0WThyTUVJNlJwTjBMV0ltcGRSWnh2T0tuMFVJQXBEVzQwN1habHY0anVE?=
 =?utf-8?B?SDR1bTVoT2tYN29KOXJUY3ZOY3FZN0NYWlR6MXRzZWtkV0VWNC9RWjZLWUJm?=
 =?utf-8?B?UUZ0K2d6b3ZOUzNZTndBeXJieEpaSmphWldBdGpPbkcyd0F1MU5IOE43bnc4?=
 =?utf-8?B?OXRYZmsvNGh0RjJnYnlCWUpCZU9rNTh1Szl6dGw1YTFCODVONVkvaUFEdzFX?=
 =?utf-8?B?NFRlajlkQVk4UmtGY1dyYjJtbUZXL3BpS2V1VEJwem5CaGd2TENFMDFqc0pS?=
 =?utf-8?B?SDE4RnJ4ano5eWMvd0NxeVZkZ0treXhOcisvNUg4SWVoTFl5YVlvK1k4RHVK?=
 =?utf-8?B?VEZ1UkhZUnFuNm1CR2lDcDlBWnlzZGZqbEVMenNxNmhrNkdvVjZTS2I5ZEFz?=
 =?utf-8?B?c2c5dlhMMEF0QTREK3VkeHltcE91bGhFY1U5OFE3WGFPRUtOWnpadTNxM1Np?=
 =?utf-8?B?aVlwMlBWZXV5dGRMa1BQTWtuMFA1V1RFTkl5UFJXU1VpQWpFYXJqOXhyMjJE?=
 =?utf-8?B?aFdtMVYvQVhWL2JhaExuNlRlL3BMaHE1eW9VdXN1UEJ5NHJ1NEdZYkVKWGtw?=
 =?utf-8?B?OHdSdVluWHdEZmVMVmZMQ1FlSEtKWWo1ZXVNYWNEZUsxdVdySmdhWmRPQTda?=
 =?utf-8?B?bFljUHdWRmhsSktwaE5icDhFdUxmZEQrV21PY0E4MDZiUHJPQnMyelVMbHI3?=
 =?utf-8?B?Q0llaUhBemFJT0tGb0QzMHRvNWxiWjBWNGxtcUJ3Y1hROE1BTGxaSGlVR0JK?=
 =?utf-8?B?ZDlOOGh6WW4zNnZLYm9GYjA5RCtVb1dHZ3NPMHphekZYY21WUWIxRFJCbC9N?=
 =?utf-8?B?eVVXZytiUllrQzFFNVB6eGVkd013ZllZQnpXNG8wN2Fuc0YyYTFGeEFMRWZy?=
 =?utf-8?B?YWNxa3pNQ3VFVXQ2dUFSNE02NEgxSU96M2Uzb2xTd094QmtDL0xiTVFIS29K?=
 =?utf-8?B?cmovYlhZM0pGWit0K1VSVDZSclByekhZVDd0akNMUTZrUzNsbEYvSTBQam5u?=
 =?utf-8?B?MXdXa1Y4UUlOaWVXMXZPMGdNeVp2ZXV2TlBzVEQzeUVidDl6Z3BxZ2MraVFp?=
 =?utf-8?Q?aTuWf5YYwSv64AfM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c189c9a3-3fa7-4012-7a4d-08de84260b68
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:06:46.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tW4Dp95Ck27eR2KZ/l0s0SrBMJuAyGnpWv9GwmE73ztKdu1FD0ZEWURgf+sJWzQCsoRjDtAWp7UFeo/YObLH4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5278
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 13:06:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22489

From: Jan Kiszka <jan.kiszka@siemens.com>

There was a stray ".so" in the auth rule, causing warnings in syslog
like this:

login[...]: pam_faillock(login:auth): Unknown option: .so

Fixes: 554b2b84be45 ("security-customizations: Fix account locked for non-consecutive failed attempts")
Reported-by: Matthijs ten Berge <M.tenBerge@awl.nl>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/security-customizations/files/postinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index f8ebf9e7..27f7cd1e 100755
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -39,7 +39,7 @@ if readlink -f /lib/*-linux-gnu*/security/pam_tally2.so; then
 elif readlink -f /lib/*-linux-gnu*/security/pam_faillock.so; then
        PAM_MODULE="pam_faillock.so"
        PAM_CONFIG="auth   required  pam_faillock.so preauth silent  deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
-               \nauth   required  pam_faillock.so .so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
+               \nauth   required  pam_faillock.so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
                \naccount required pam_faillock.so"
 else
        echo "No suitable pam module found to lock failed login attempts"
-- 
2.47.3

