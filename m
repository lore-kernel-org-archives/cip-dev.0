Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475BD111A8
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 08:08:58 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16597.1764576533797115809
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 00:08:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z6rBNgTx;
 spf=pass (domain: siemens.com, ip: 52.101.69.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAxDViMZ39oUq3CdHN2V5R8a27OoFplj0liblPCVoHXCICZfg5HEj/YmjGvNLpj7eaV7bLh6vGfjwTQsRhJbNy7Xj4pFmduOE68AV4Rz9t6zWsiNlnE/qbhcMMhXX48JprXtINIy6GvvEtoZ1Y1OL/Q3svOZKZUsvTR9rtUdyxfB7xCPGwdUl8veR3HvhJaZEKXPU1369LyzcOE8sqrN90hGX0Oo4HJohUVQ8h5ExG4qMmiN+rsmKMMtKRIAcO2BBIqYh39/AA7/BDZHJDGnHwgatXd0m4wBRURTGz44kG7fsxSDoRM0YFyZiuAK6SdaNB/qcrf9eOWSdGT+EWyT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qBT4tO2sKj/LfeO34EwYDJwmTnKrSjn/40biBgfAEM=;
 b=aIbV5n5QkfFWyNoorF7c2wQTTwbVI29F/T9Fd7ai2sc/dV4VzVWKFVHxZVTG53QW+TcYF6KHHEyjYhU34Ya+m+w2uMbuMISK8MFKbgiZpZizzyoB0zXvVxFRlgXsW8XD3dgD5coy7W8OcZEEao86bdkWm/AvEp42WiWArcMQ57U9rB4OySTJmUNAJ1yMKyDLWi23NE+mCSaSrHKcPzz1RlR+rtQaOrlktXTEvGCMkoMPx9dH+BHysmoORTJ0xAXpfdxYOOaFGI7MwVt4kK8cWQgSJrGKZ18HLavMZUYgeWjYHXCSKaecUr4j4+y0BtAPu2b+ikOk7MmO8LqNwa8IyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qBT4tO2sKj/LfeO34EwYDJwmTnKrSjn/40biBgfAEM=;
 b=z6rBNgTxUmk8OoTFDCKfo3kXYNCjoonbhKhXbFdE1ZBXfD0i45XEQlLA9nt5X7HrEDgpkHu+YZyYx1LmNZWhKpnlcwzUhOwv1xKhKu9st2Z0rYjoZJNYJHkUeOhuv1cyMruBXu82g/nWYjQ81fIqrMVL0DOpaTCR4akREQ/WFLETrafxhtTt1Ixo6+4LywZSRRutqFb4o8zzGiLCrnJbmpxoxKEL4W2HGlSb9Bi2YwpBhxP0jLszoeljH3Yf/CPSxW/D8Cz1B9mW/aR1ahq1Q4/kuJcFuhUtICvy8RBzl8H9yh+FnS/tmSpqTPL27Z62G4w0VcQWJjBWIi6JkiivqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 08:08:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 08:08:46 +0000
Message-ID: <fd81fe72-1b20-4a65-8f29-ce4e81e63385@siemens.com>
Date: Mon, 1 Dec 2025 09:08:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-cip-functions: Use time_elapsed
 function
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0358.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 65430915-2210-4edc-5b0c-08de30b0da10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K3Y2dWhtZXhQMWZodEtMTXVQeFFZajJoUFM0M2hrZ3cwK0MrOCtPODVrd0ty?=
 =?utf-8?B?WCt2UXNabEpSa3h0M1ZuTEppMzk3SzEwa0xCUU1OQ0kzREpvd0duT0FGS3ow?=
 =?utf-8?B?U0ZmZDRLQkp3RmN0MGgxOEtDSVgzaDBSNFM4NzhhYXZmdHAzWDE0UlkyVWVU?=
 =?utf-8?B?TXdGakQ0TlJlTlVsZEJPeUdDT0ovYUJrMGh1WXY1MmhFaTZ4REFUdS8ycmdW?=
 =?utf-8?B?Sk8rdk1JL3hjWEhMWUFSaUtDVXNmOEdDV3hNVDlMTGllanRZQkFGSXBJdmph?=
 =?utf-8?B?YXorT2RkUC9Gb0RNWTFQSk9VOEh4WlMwbEFNV0FDKzFuSlo3U0RMWDRLc2l5?=
 =?utf-8?B?YjhXeEhCaW43ZWNzNkdWYnBrRThIVEt3TEZyZEJhMFRpd0tXZEN6V2cvTUpZ?=
 =?utf-8?B?Y2JxcSsyNjBRRFIza0I5b1kzc0lxNXpTSVhXakRkSmVEYWVjNWRsT3ozdUdE?=
 =?utf-8?B?MjlMN3cvK3hZTzBnZ09ucUNkNDRQeTZJVEF5emV2TE9TKzVpbXhOMnRTd1dT?=
 =?utf-8?B?dTF6d0FBdUY5WkpONTkrakRSWmdrM291ek9kb0RSclRESE5tVmEzTDh0b0sr?=
 =?utf-8?B?NDRTWFdQMUFSMTR2QjkzcXdIQkh0dlZ1RFYvRStlQ2xvKy9BdjJNRTcxSlhi?=
 =?utf-8?B?TzAydTVtbUFDcC9NUTlIVVZkOTlURnZwa0VpUTdoS1FWcmdWZWNRdFJMYWZI?=
 =?utf-8?B?dVNuT3MxQUdVVUd0Vm5wdDNpMHFiQzJSUnlCT3k4dXpabVNLcUJacXBlWEtm?=
 =?utf-8?B?YUxzWkc0c2JJQ2pUOUpxTXh2ZnF6T2M3WTJwMkpXcVdIZ3lmZmZMbGhhbE5a?=
 =?utf-8?B?bVlCQWlHa0hOU0RoUm05VGR5T1JYZTBjSnUvYjNlcFJTRUlPRzliQ3BmT1ZV?=
 =?utf-8?B?ZTRLV3JDUHJqUkZGQ3lXVFBmM25xWUhkTXA4RGRXSTlkWktSNXhSZXZock1u?=
 =?utf-8?B?SVdRQjNmdUtyMWIxaTdTVnZ0TUovdkdhbmNBcmsvU0ROU3Y2RU1jakhFN2Q2?=
 =?utf-8?B?UDF3UkZTVmZEUVhidWxxWHluRDZsazEzUE9zNlUxRlNWMGtvQ2l2TjFYZXJs?=
 =?utf-8?B?eDdPUWsvbFRLQng4TGpEaWhPNjZEM1daQTNjSUlObkNNbmtlNFhBNXJ6SDB6?=
 =?utf-8?B?RU5CR3d3V0FjMktYOGVhQUtNMlYwSS9vNWhwT084SFk1dHJiOEZ1Mk5QaU9L?=
 =?utf-8?B?RCtZdUliNXpocmVaZVlRdmhjQnBwM24xWEdIVTdzRUY5MlRqVTlMcVE2YkJh?=
 =?utf-8?B?ZXB5V1k1WmF4eEtWVzFCNFhNYjBQamRIamJwSmNaYTVGaHRUUCt2bWNXNnU2?=
 =?utf-8?B?bnhjaUdQVERzd1BnMHZscGhaVzY1MUdPWURCNUM1Zk1oMWxiWVRzTCt3N3Bp?=
 =?utf-8?B?aHJhY1dSeXFYVTI5czRWL3A2dGJJMmJ3bEZmWmVHVElOeXBnQ0p6NXg3ekJY?=
 =?utf-8?B?b2FjcTB1ZXNjcGh3cVFGWWhoTXVIMTJCeTE4Q3YvUXBsUVY5Z3V5Ylo5N0hT?=
 =?utf-8?B?OUV5M0twSEFIN1ZPREV1WU9VWTBENm9kdmNsQTVTU3YyK2dhWUI4Y0k2dG9L?=
 =?utf-8?B?Zkxud3pyVHZsc1BqZkJwcDZqRzdyRzVvTWNVTU5BZFpOR1FBVVkzQms1OXBP?=
 =?utf-8?B?UlU0d2pQNjI2Y3ZyQVFSSytSNUYxcEJRMVZsWXRSNmU2ak8zdmxYejJGenVk?=
 =?utf-8?B?S1ltZ2F0cWFHbGFDYU9KNzczMFhUOVlRYVA4SU85ZldiWW42dWZDN0prQ0tz?=
 =?utf-8?B?VU0yYW1OcjZKc1NoVzRLdWZwSG52NnhQaU1xRTRsSk95Q2NYb2MrRERJTmFt?=
 =?utf-8?B?cFpycU1aZU9BMnlndHI4SisrQVY0cms2MGt2QTZ5eFFUd0liRTFZUjgrZy9i?=
 =?utf-8?B?VjVhZnE3amROSnJ0MFZWOHpwZU8xUStDT0VPWFNjYUMweCtZVXBpVHlPRUVn?=
 =?utf-8?Q?XrTJAYsemyfEtfVrENXY90SFdhSE23D5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K3NXQVljRVNxRk16WEEyQlJHS1ZuckZQZ3JDbXN4cnNyMmtJcWhJb05ybHVS?=
 =?utf-8?B?QXI1UjZiTlBqWVZEUWVXMWFaL2NWZG5ncjI3Y3V6YjljdkNaTHdCdk9qVGRX?=
 =?utf-8?B?U3BKRjFDeXVEZ2NrZldaM2x0Wm56bFFmK21XTThacmVtYWpFTDAxQitGbXZm?=
 =?utf-8?B?Tjd5V3UxYmMraUh5UkJ0a1J5d1JoWWVDdS9jMzBDUFZyaS9BQTBxZ3Q3MGdQ?=
 =?utf-8?B?WmJZOGxvOW96U3Y0bklyRWR3cE82b3M3TVVJM0lHOElVK0dFdU5aRU5DVExE?=
 =?utf-8?B?OWR3ZFlQdUhNNk1OUHN4dUJPNUxNb2xWQTNzemdSZlNBS1crdTVYdkJma3ZP?=
 =?utf-8?B?QVJtM29NWkdrenM2c3NnZVNkY2lIOWJxRGxObXRuRldnaENxalcrNjlWYkpj?=
 =?utf-8?B?dC9lNWVvamx5ZGFYOGtiaEs2L3BvQXhGZWR1RHBhbTRYM3pEZHJFQ3NaYVpi?=
 =?utf-8?B?N2RlU2VtT3lEcW9JOVZSS0d1Ym9PZ1EwZ01SMVRCeEJPNW9yemwrWUFYcWNo?=
 =?utf-8?B?R25zUHBRYmtMUlhTOUVHcGh2ZE96TlMvbjZKKzVCamVVM0tzeStGcVlLWVFa?=
 =?utf-8?B?aGU3TVNzcDdDRldMbzNnS201c0hiZGs2NmlxanlieGg5M0Nmd1l6NmFDWk1y?=
 =?utf-8?B?KzlIYk11dDFTczZpS25lcUE0cVllMktQUFphdWd1a3BXL25pV3dSMy9Iay9X?=
 =?utf-8?B?VUI2MVBKb2pPSVNlQkd1alpyUkgxWWhOVnZSS2xYRFNxNVhyL0l0Z0s5cGZv?=
 =?utf-8?B?eGZwZHoxRllaLzA0VGN6VHltSkVTTkZkdUYvUU14T3FyWHkzcEpBTFJzRk1V?=
 =?utf-8?B?OWVuRkxDalV0Q24rNSt3TStMMTlJUGg0bHZEWWVPMXZTb0Uzc05BdlJjWGZl?=
 =?utf-8?B?VXA4T2tTZHNZUVBucldoQy85cG1ySEhTQXVFd1pYRTVlNTdDSG9BVjk0MkxU?=
 =?utf-8?B?LzBQTjdCWXNSSmJjQ3IzSkRtNkdUS2licVUvWFpLNzlqVWwvOExpTC9TS1la?=
 =?utf-8?B?OWpNZStyYzkxNG9FSHJJbG5sUkphTlJCY0N2bDJJY2xXL3lEenpBQzBNbExm?=
 =?utf-8?B?WHFQTWVMOHNiaDBydURTNzd1OXVwL1dJYzh5Tis5clF3MndQTlVVaC9RYVBT?=
 =?utf-8?B?b1Y5N3BtUVlieWkwc3k5dTBNaUQwc1BRb3FrcW40YytzdHNqZWdmRXM3Ryt5?=
 =?utf-8?B?QjJETmt4QzQwTTRnKy92SFZVTXR0ZjgxdStKNER3T3dRbU9veHhBZ245TG9h?=
 =?utf-8?B?eGZjSGpvK24wYll2MGJsdC8xNE1xTG9qclJNZ2I2Y2VzMWdzbUZXWTk0a2tu?=
 =?utf-8?B?K0EyUUZRQ1RQbUJkTnFkU2gwbGNLbXVvcUNzQml5UE50bGZveHI4Q0FXYmY3?=
 =?utf-8?B?SlVJRFk0eHZXWFpSK2lDL1JlUlBtL1VSKzV5NFpBWUMwVE5PRGEveVdjTk84?=
 =?utf-8?B?VXJEVTdqTW9tUXd0WXhjaVJEUk0zQy9nY3h0N2tpOElRaWdHTmgwL1RsSDZw?=
 =?utf-8?B?dCtnK2FWRnhEV01BTGgxWDBMNGxSNktBV3pWSmxwMHY4RVkrdHlCUnliNTY3?=
 =?utf-8?B?bUdyVkxTMGx0RzJBMG44M1NtcmN1V1liSGdkTG1SL2pvUW1BUkFqeWxWZTNi?=
 =?utf-8?B?aDFlVVJIblMzK3F5NTRMci8yWjh3VGFpL1ZXd3pLWnhLSHhMeGpMNUhXcmtv?=
 =?utf-8?B?VTFFdWUwU3JJRjlKU1YxbUUvYy95aXNHM1RHME9yZ0l1a2RxVklRRFA2dStw?=
 =?utf-8?B?L2hWKzhHRGN4Yy9TVU9ySElUK2l4YmsyU0ZZeS8relZ4YktQcjdsRnc5U3ln?=
 =?utf-8?B?aGRIcThqdDc2azZXOUNPQkRiZUV3U1psSk4vMmprNVhpcE5uNlNZd21KTkdM?=
 =?utf-8?B?WXlBYlNUSTU4WFpSUSt2Qnc4VlozVjdBRXgxbEZFM3RjQm5BdjRveXJWM0lx?=
 =?utf-8?B?aUxOK0tMR1hmQUo5YWxpOHprQkpOM213YTVyaWlMU3YwNW55RjZScmtvVmRv?=
 =?utf-8?B?RC8vaG5vOEVrckEva2w2UWtZczgzOUFhZ2x6cC94ZktCV2JIdGpDUWNnL0lv?=
 =?utf-8?B?S2FVT2taSVRXNmtyUW53Wlk0TXpOV0VrZysyWHhIYjlicWdWeENpZ2hXeXZ2?=
 =?utf-8?Q?+lgzV+IP4duiUmrk7+w19yH51?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65430915-2210-4edc-5b0c-08de30b0da10
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 08:08:46.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVXPLrChcvLhWjhV0yltmnO3hrrOEwuqo8b/UnzuyXPOLf/lg1jxON/PRZ+FDfLwLGyyjhCQKvYEGGHSiEmrKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 08:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20776

From: Jan Kiszka <jan.kiszka@siemens.com>

This is provided by initramfs-tools, does all the math for us and also
takes the actual elapsed time into account. When the target device is
slow or the check function is complex, the current implementation waited
longer than desired.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-cip-functions/files/cip-initramfs-functions     | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
index d87bdd0a..a4c1fed6 100644
--- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
+++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
@@ -19,15 +19,13 @@ wait_30sec_for_condition() {
         panic "Argument for function wait_30sec_for_condition is empty"
         return 0
     fi
-    time_elapsed=0
     while true; do
         sleep 1
-        time_elapsed="$((time_elapsed + 1))"
         if "$check_condition" ; then
             log_end_msg 1
             break
         fi
-        if [ "${time_elapsed}" -ge 30 ]; then
+        if [ "$(time_elapsed)" -ge 30 ]; then
             log_end_msg 0
             break
         fi
-- 
2.51.0

