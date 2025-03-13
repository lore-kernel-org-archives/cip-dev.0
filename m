Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C3DC28B2E
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 08:07:59 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.50])
 by mx.groups.io with SMTP id smtpd.web11.9393.1741853276626181473
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 01:07:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uCWOv5+0;
 spf=pass (domain: siemens.com, ip: 40.107.105.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn3UjFA7jnDBkPOU4iMpsGntEfFg3HeSsfdzp0Xruhx3uZU+zppZ8GGiGG/zHSOh7GRXPx7kOZtGaxUKRN6Z198TpRVEjxamkZyq10oiLCgH8qKysvScL/HYIUJp9jRC5LyJqpeQLNZxV0QYEiESc9lAxPqWymPKgNbvBKBDiaejtbnwBx8MpuYE7H2DrIOKdVUhLPv0Tw6XosgFYB0zkvfyoZYAhUdAT28KyxL5iY3/QVO5Czs3pPri+Zf3M39XGWy5N369aoTpEHcgAhFNXRZBlsOPvt33IDG9/E+dTzFiwWAmsa+pTl2OlGSQC4rrgKmO9xDRy7NO+fHi2nbzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62dTSVySvjRiq+LBy+Rzk8kqdGPKC5emoUn4/XRNwrM=;
 b=eEILU1KzajDJOt2RPXjW7WicOI4aBTlIIJzt3lu2ZPCyuuREIYNEigXfGIeCZDdcT1yMGmp0GFfKO9gLKS9Zq6ets2wc4Y2/pdwucy0ytoaTWUntc4gi21mOyCTb1HyW9JGfTlza5toEGF4ZNRubL3j7C0hia+SxN3ARAXGTAnmKTxDKpRZqmsWFarx0aA+wL/a/gZ+pXYHhHMb+olVVziBT8PK7zqNI1F8gxp4ZmI1TJ35aXG1ptVkehNw5wTzNpZmdWKRzCY1f37Uaz1FMUQJdv59Yz/iTB3MQeoPaqKzY4XQDJRYr6nafQIXAIluit52h/MCqvetkEGyCgznT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62dTSVySvjRiq+LBy+Rzk8kqdGPKC5emoUn4/XRNwrM=;
 b=uCWOv5+0dflPmD3dakKkpFMgtYghCPCh8dSrxxIPe9QYKIw3hPOlNBDP9yBiiUjDptsfP0i8GBltPWpoDr3tz4yS+6/IbHMADDz4Vz7BzAU6y3ghKOS8c4EK69X+L/Zc7ByxA/E4lMrxBcqDc1e89tn8/N3fShqBF9mwWokNegcbv1AfT8ZuviK0JDfcOdjgEKs89kDQES1UsYhv+Qa1dNPE1NUMYP6gM2HVtACbfYNeYfgcDWcHEoLXMHn9rFIvotSmD0USpuKvp1aWthZJFSt4agGQJjRchWRIw2nEZPo/seln5qLNL/gwhrUiufyOfHrhQyl0AyAMFPfUYQgkYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 08:07:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:07:54 +0000
Message-ID: <c0e231b0-bfd2-458c-807d-3902eb6605b9@siemens.com>
Date: Thu, 13 Mar 2025 09:07:52 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] submit_lava: Address shellcheck findings
Content-Language: en-US
Cc: "shivanand.kunijadar@toshiba-tsip.com"
 <Shivanand.Kunijadar@toshiba-tsip.com>,
 Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 490fd606-e0b2-49c0-d1d5-08dd62062816
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHZDY1ErcDVaRzNXMmdEQ1NGUkY1dU1MY1d0dUpLKzFRc205UFpqYTBVcDNm?=
 =?utf-8?B?YnhoUWxJQU9vRnNPc1d1cmV0SUJGQ3FwNkRmeEh5aFJLajJWbVVYVFZrT2F5?=
 =?utf-8?B?TWxEQ3phUE5Sa3h3M0xpcTBNYWtBNlRSQzFhcWYzTHhONzRSQmQ0SElSQkpM?=
 =?utf-8?B?V05BRytJRnV2LzVIODIrTFpJQ2kxbUN5TVpmWWlxQk1XbGhaeHRiTHZVVHBP?=
 =?utf-8?B?S2xVeElRTkU0b3ZsMHdIelFXSVhDSmRWSnVjU0ZJTGQwME1STXNEU0Q4VkVS?=
 =?utf-8?B?R3BiSHlzRnRMT3Z0SW9OVGNGanhuQUhmd1gzTFlURzZzcFNRRXpCdzdKVTFP?=
 =?utf-8?B?dzl2dFB4YUtmclJjV083Y3lYR1hCeEthSUZMRjRiWWtpSkhiem1OdXp4TDhu?=
 =?utf-8?B?OForZDZ2Z1R3SXpxd3Y2cTZFcm5FdFN0RE0xazU5d1NZQ0pVazJvblRBWGox?=
 =?utf-8?B?emNES2dpOXI4OG1BL3Z0ek83OGVpL21QY1ZIRmUvTXptcndORXJZbFdIek13?=
 =?utf-8?B?bXFnYXRMRzBLUjRDQlIzQ1hTcjhEdTI1bmthYnRSQm85akluSHRTZU1sZjUr?=
 =?utf-8?B?NC9KeUNLRW94dXQweXYwWUVBL2w0RFhoVmRRbjVFSEtjUnpCTmlqZ0RZSjlM?=
 =?utf-8?B?RkcwUHVyTFhZMzVGR20zQkxIVTJ4cVplUTR3VDJLUy9IdDVHVmdzSjFOUEJy?=
 =?utf-8?B?QkRpanNKY3o0N3k4cmlYSC96U3hBak11WjFpWk5yL3VFdWEzeGVJQi9EM0Ju?=
 =?utf-8?B?RUpZdk9lRUxCbGVMTEwwTzBTc0p5QjAzckVmUFc3aWtqdldwU1NybTFhTVRV?=
 =?utf-8?B?SVV3UjllWWg0MmE4NTNNUU40T0YrczlWVEdaaVUwWVN1My8xVkFnMjdhT2Zk?=
 =?utf-8?B?UXBjQ2hpVkpjUXc4bVNlQTY1dms3eFNZeEtaNkt6TmMxL0d2YmdjL3VwRyt2?=
 =?utf-8?B?T3hORFFYaTZIckx6TCtWTWFZeEU5SUFzczQ4M2hjcVVuamRQVWplUTEwZU5n?=
 =?utf-8?B?S0pkODRsU1N5Qlh1SGlldjU2NEsxRGNldzByQVk4Z0VXUThLSVBUK0wyaDEr?=
 =?utf-8?B?czNVRTdPcU8yemRNM1NHSGd1bWhDWEU3OE1nMmhUSm9HT3JsWHNaTllrM1Rs?=
 =?utf-8?B?eDlJOVlzZGJyeVRKbzA0RzJFY2orYW15NS9ubElBNzVFa08vSS9pS2k0QlFL?=
 =?utf-8?B?bHhWcFpEUW5HdDBLeFhCcThCOVBHNG9nak9OTTlraldQVkdBK3lTYVVJcUxS?=
 =?utf-8?B?TkZWby92ZExmN1crOXRlem1vNTI5SUJudXZvME45TFUvUHlzWE1mNnFJeHlk?=
 =?utf-8?B?bElISzdNWHozMEgwUXBhUkd2aTFlSXM5VlJDM2V3WnNjZmhUR05MMHMyRkFO?=
 =?utf-8?B?S1Vaay9xNUh1Q29VK3N6UWRzOEh1dm4xQkFhL05lQ1Fyck11Z0pUU0cycEhk?=
 =?utf-8?B?bkdpUEN0bEdkNGl3VnFnQzgxZlZVY1d0RktsKzlBNXRxR3gwcVo5Y0FhbFRM?=
 =?utf-8?B?YXhHVnVCNUZLeVVEd1VJS1doRXNvejFJMThNdEJLSEIxS3ZvTm0yWU1MT0lv?=
 =?utf-8?B?RnRlQzk2RFV5Ynh5Y0NhWkY0enZOTXJyVWloUWVaTVdtWi96T2RUbzlsVXJp?=
 =?utf-8?B?ZVN3SkxFT1ZxRytObHJJeHhEeVJjelYyaVd6MW4waEdpUW41cGtEamsva3NJ?=
 =?utf-8?B?N2I0RW5uNjRPN09XYXlVRkJHQUxWYml2OWd5eUkxZVlmaFJLRXFwWWRVYnpM?=
 =?utf-8?B?VVAyd21tZnAyeWZFZCt4WlFMSEpBVEFQelo4OE1UcXVNMFFIazF3eUpPUkJZ?=
 =?utf-8?B?TE9mSVlqWnA0M1RMeXY5dDZ6VmsrL1psUkhEbFd5Smt0VDIyeXVtd3owa1dF?=
 =?utf-8?Q?tSTzuWkPnpjUR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVBJMlFlUFJ4Nnprc2Z1QXlrNXo3bVB0ZGdUTHdrcFVZaXNXMEtvZG12TTJh?=
 =?utf-8?B?eTVZZXBMSXRRWnhjTWFYMXhSQU93eUFoQlNxVzZZWjI5R2VPWXl5U0NiNUps?=
 =?utf-8?B?dHRwZzN1QllrbnorOEtKNWIwaE5mZDM4bnVSZnNFdWIyN2doRzYwc2ppYXJu?=
 =?utf-8?B?YjJhNVdWTjN5YkdPVXVWVE5xNXNLUkp0VjREL01UdzVEUk5neUJYM0hIREU0?=
 =?utf-8?B?Vy9WWFZOaFFBWE5wODkva0tyTWRRcUJ2aDFoeGxJaThjaUNPNkl3Ym5PN2VB?=
 =?utf-8?B?QzhETnd3NzMzSUtYZDdMbzlmSStqY3lkSnIxcjZoNDdHMElCNzV6QUtkY1Mx?=
 =?utf-8?B?bkdybDNhZnBJeTVTUzNRL25idHRTMXMyVktEV3p4c003TzVIOGU2c0k4MXIx?=
 =?utf-8?B?T2hLQ2tMeGIreE1XNmtnQ3VVaDZPYUpCbEF6VG12MVpXSkZ4aUMzb0h2Skxw?=
 =?utf-8?B?UlV6TFcyTmN6QzRiUU84aVBLV2JVR3JpeDJOczF4K0xJL3RIeU1mUVkwZE9q?=
 =?utf-8?B?SEVWVjN1WWFvNkIyTEI1bHQ5U01aWkx0L1doOFVmMXBnaXAxKzB1VHRvYnF2?=
 =?utf-8?B?OXFzbjNrclRCL3ZIc1NadmtpWnVIN3VBUUw0LzlNZklCb1M5UFRYMTZkRWNk?=
 =?utf-8?B?QyttWnJ1RUpZTmthWVZKai9VcVdhU0U2eUVLdVdrOENOSnVCSm1pbC9kS3hS?=
 =?utf-8?B?elEyMXMvMVg3c0ZrZHVZekRoMXZMSkVxUTZGeU15WkNibnQ0b05SK1pHODR2?=
 =?utf-8?B?VEVJbXZpNkpvci9jN2I0VXhoaGZHR25sRDVTeFNpcFg1K1RzY2Y1R01JdjVG?=
 =?utf-8?B?SGdwZ1p2OUdaSXlORFFkTUg3NUNPSWV1YWFUNExTdGJsSHdHS3NMekJ1bTRF?=
 =?utf-8?B?N2RpWGRXaGFWOHcrcTJSdm43aWY5eXpWcmVRbmwwaDNRRGZia2pIN1dpQnFR?=
 =?utf-8?B?clB5Qkk5RXBRMXprYnY3Ym1KS3dXcVQ3UGpIa05CYXJjSkdSOUxZb2tHL040?=
 =?utf-8?B?OHJzSHhpYUN6Q2hYRHdUV0xJMURlejJZazJTR3IzenJJOUlFWEJtVWtpNWYz?=
 =?utf-8?B?dHNaS2JoWnF1eGRFV0xBNStzMFYzcVJBN3l0L1Y2ekFCMXpYL0ZHZlhoRkkw?=
 =?utf-8?B?SENybmg0RDVxUGJONkNsMUpnYjBZNVNLU1h1TzEwSUcvYUdhdU8yVlJINitW?=
 =?utf-8?B?T2RKV05IbEorNGVrRjJnSnBEdVprSHpyckhIZ0hhSEFuRnB2U2ZiUlpkMlpT?=
 =?utf-8?B?RUZjVE1IVEpRbFllaW9BcXdoNDd2TU1PMGlXR2tNZDNKQU5paDJJamVNaHpl?=
 =?utf-8?B?STZuTk9ia2NMc3hJRWVoTFZzTEFLbk5Uc2pudGMyQ2E5OVVsazVLbTBObFZs?=
 =?utf-8?B?b3pENWwyQzVma0pMejZVTW1NaXRnS0dBWmZZclN5K2tYQ0krR2JmODBXVnZC?=
 =?utf-8?B?UTEwSHI1ejlQeDdOSzJDNjZoZ0FOZkh5ZG11dEtKVit5MjNNWTBiRy96Unlw?=
 =?utf-8?B?dkRUY3VPbWkwRlpuMDBGNkozbWtnYUVmNTU3MlFmRGUwRFJ4RDhsakFJbTFz?=
 =?utf-8?B?OFVwTStYNmZjbERQVURXV3FxNEIvVm0xRXdlMDVORmZBSE42SkU1Z2J1cFQ1?=
 =?utf-8?B?UzNBZXNpeHZqa29LOFg5Q1ZCZFNDR2FBVFpaR1hJTXJtV0xaTS9Qd0dwSklH?=
 =?utf-8?B?cEdwaVI2S0pKZDYxV2FtODhqclc0emZ2Ty9MZEk4S2tZS292V2tTVXp6NUIr?=
 =?utf-8?B?aE44c1paRTMyRDZXdWcyVmpMOWtOenBlbzAyWENlaWJzNlNkWlVRZFNuZDdi?=
 =?utf-8?B?VHNhVUhiUzlwY04rZ0FOUHFzL1RyMDlaYTZuVFowb2lZaGFCNTRTWnZUckJy?=
 =?utf-8?B?UXpVQThla2xLNFdzTHZvRm8rY2NkK1pnQTZHaTVvQVFTVFVpWWd2TVQxN3VZ?=
 =?utf-8?B?bWZiN3FVOHUxRUhCMWMrNHVNY0d5aXhrOVlDVUxrVVgzODBncGpqRkdzUnRl?=
 =?utf-8?B?ZFh5L1FFblh4YmNxMldHSVJmNkpSSVR6R01wZnlZQXovOFRWNXE2OHBNclBE?=
 =?utf-8?B?enN1anpWTnJwM2k2TFFjVExwRGplb1ZkcnJVY0lBZ1N4QWQzVDc0QjFwT3Z3?=
 =?utf-8?Q?hRsyT94l04b/fn0lHUslpfWhN?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490fd606-e0b2-49c0-d1d5-08dd62062816
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:07:53.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iij63n1463cIGUSHxEeTsrFw32Sg6cOy4naQM8UVLwi8aw6ZaWLoPuBR9t3rAh2YyQTciAKB8boWQVBhV0rghA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 08:07:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18182

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index f35ff0c3..a9bb0118 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -162,9 +162,9 @@ create_job_qemu () {
 create_job_mcom () {
 	cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
 	if [ "$1" = "IEC" ]; then
-		grep -A 9 "# TEST_BLOCK" $LAVA_TEMPLATES/$1_template.yml >> "${job_dir}/${1}_${2}.yml"
+		grep -A 9 "# TEST_BLOCK" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
 	elif [ "$1" = "secure-boot" ]; then
-		grep -A 1 "parameters" $LAVA_TEMPLATES/secureboot_template.yml >> "${job_dir}/${1}_${2}.yml"
+		grep -A 1 "parameters" "$LAVA_TEMPLATES/secureboot_template.yml" >> "${job_dir}/${1}_${2}.yml"
 	else
 		# swupdate -d option does not work on M-COM, so .swu file is deployed to downloads
 		grep -A 7 "deploy:" "${job_dir}/${1}_${2}.yml" > "${job_dir}/swupdate_deploy_download.yml"
@@ -176,8 +176,8 @@ create_job_mcom () {
 
 		# swupdate test action on M-COM is different from the test block used in QEMU
 		cat $LAVA_TEMPLATES/swupdate-test-action-M-COM.yml | tee -a "${job_dir}/${1}_${2}.yml" > /dev/null
-		grep -A 12 "# BOOT BLOCK" $LAVA_TEMPLATES/M-COM-x86.yml >> "${job_dir}/${1}_${2}.yml"
-		grep -A 16 "# TEST BLOCK 2" $LAVA_TEMPLATES/$1_template.yml >> "${job_dir}/${1}_${2}.yml"
+		grep -A 12 "# BOOT BLOCK" "$LAVA_TEMPLATES/M-COM-x86.yml" >> "${job_dir}/${1}_${2}.yml"
+		grep -A 16 "# TEST BLOCK 2" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
 		sed -i -e "s@#updatestate#@2@g" -e "s@overlay-1.1.1.4@overlay-2.1.1.4@g" "${job_dir}/${1}_${2}.yml"
 	fi
 	sed -i -e "s@#test_function#@${1}@g" -e "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}/${1}_${2}.yml"
@@ -257,7 +257,9 @@ submit_job() {
 
 			submit_squad_watch_job "${ret}"
 
+			# shellcheck disable=2086
 			lavacli $LAVACLI_ARGS jobs logs "${ret}"
+			# shellcheck disable=2086
 			lavacli $LAVACLI_ARGS results "${ret}"
 
 			get_junit_test_results "$ret"
@@ -288,8 +290,9 @@ is_device_online () {
 
 # This method checks if the job is valid before submitting it later on.
 validate_job () {
+	local job
+	job=$(find "${job_dir}"/*.yml)
 	# shellcheck disable=2086
-	local job=$(find "${job_dir}"/*.yml)
 	if lavacli $LAVACLI_ARGS jobs validate "${job}"; then
 		echo "$job is a valid definition"
 		if ! submit_job $job; then
-- 
2.43.0

