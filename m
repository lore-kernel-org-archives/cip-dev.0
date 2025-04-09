Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC255C369A1
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 14:01:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.64])
 by mx.groups.io with SMTP id smtpd.web11.9331.1744207257052598842
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Apr 2025 07:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=i010FGKC;
 spf=pass (domain: siemens.com, ip: 40.107.22.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsM2IJFf3WsgbJZYhXv1/D/AFVvrVSFXx33YfUtMM93qJqIG1epfxVWXDeKPWMWdo7a+3mCRquin0Pj3Z4+mX4w6Jjb/taYIDCpKURgVfztBYH69s1kqP5YxMHOsYh/w/EmTxEfITjSMe6o4aDIKpOwPTw4SdpA0s5YBFYMcpOtPdxv5qH4H3CtJkMn/XsTXl2y8bSRlE0wMnqkAWyohtrZd84gw4eXDCDzU7zLh1jjDZX4mx2I54uuVOgyJVSI5cz2m3+obLc9dKVRh0NLk/IQbF1uxHH1DuzPixPBvaCUTOnSS+NJS2Mwd+de2U9HTKZqqqxWpAybEW5rDkqgfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETT56mkC67MNJXKfb+IYhCS33pu9yXHXmztl7RcraC8=;
 b=JAwNWGFsPXn9fN4AVsHkjCNnyMLWdReV51yRGlBc/IawKKeNMF0AyyWORAZM35pC0y34vHScGveXXJFrQTAfr0yTbmNcvUz0q/TtmJjno5fME6wQNPeQx7BvdQdRRgnPMpENImJ+XkJngLs7sfBj9sZ2rQmWrHasu1SWHLTYK33VoUjyi3Is0KDkCW/CBh6yQNJeqWjxGbIWlxcn2YAAl3Cb3BjqRzNjzN+ywBqTyhqjY/8SygjkKy45NgNCZBR8es5rxbKNGqQQQIvc+3Ri4TGsfgJnK9iR5wb9lPhtwcWGQsBKVVbNPcQ8xMPnhS89qaiG51ehdghv2tSzjY0JuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETT56mkC67MNJXKfb+IYhCS33pu9yXHXmztl7RcraC8=;
 b=i010FGKClYggp6k7kVLwslxVBhCriODnq5k7zU18eXbm8PImUcCCWeGqeXvGS+QR1MFGz4Hh4nYpCmnm/yxtGSCD72tZh/9AgFiDd63IoO5xDDsjmGo3UPUs2rHIl1lkUytmhRLBNMoDc+/lsg3TUbIFh7jFPFH/M0NXjnCcU25gNvKKqJ5HqyjCvodP0L/gtPt2R6/2V6qYxDJMm/yzblqZoW96xmKTwehqELrkTeKJJbQgp96tZdpt4qeYbPd+EIg2ptlJDjstOilkEwkftVFxCy7zFIuwlY9AEog5om9OQ3v8xTwRvhjYr8j2Y3D8Pzz72Gzk9GYgsGnNbms5YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 14:00:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 14:00:53 +0000
Message-ID: <9db4efa5-64b9-4441-a314-e9c214079341@siemens.com>
Date: Wed, 9 Apr 2025 16:00:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] immutable-home: create relative
 symlink in rootfs_postprocess
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250409082659.3828643-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250409082659.3828643-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: d04c1ace-ad99-403f-87d6-08dd776ef128
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?enlLL2dCU2RnaUlLWlo5OUFXT0t3aGdzUms5YWZnd2ZOdnp3NGxSWS9LNDBB?=
 =?utf-8?B?eVMrbU83ZnAvQTc3bkR6WEVMNHFFZ2hoWjBueUNRVWc4bXh0MHRNOThnUUlQ?=
 =?utf-8?B?SG01bnh1MFpVRFF0ZzZ1T3d1a2RlS09mQ1c5OEZzS1FYVlNLbjFOR3Q0engv?=
 =?utf-8?B?dkNmTzBmQnpXNDcxRDNibnJValBVSnk2My96c3QyZWV5WjVXRzBUT2lRc3ZV?=
 =?utf-8?B?aXcwS1NEVldhc2o5WTJQNEU2eHlLZ0ZQZmlIUXRZMnVjaTNnV0k4Ym5hSjRQ?=
 =?utf-8?B?aWR2OTVPL3lOT2ptZHlWb0Z4dkxvNlBTa0sySlZ0Q2N3MDdNS2VUQXJjcXF2?=
 =?utf-8?B?UW9PU0pkK1NDQXZzd3NOR0pZckZvblAxQ3R3bWFmOHJrOEd5SXRFS3Z5WFcx?=
 =?utf-8?B?aG9sdmxiVFA4dVNVV0lyZ0JyWW5UY2ZSY0xYQ3ZvNnRFaE1XdUJhOGRiRE5p?=
 =?utf-8?B?Ui9NZHdIS3V5bmhSdHZUY2RraWRQYTNianhXb3BYOW5nN0x0Y3J5ZnJDMVNl?=
 =?utf-8?B?angzd1JNeWMxaDZPRVlnZUwwemYrQkpHRTR5MWE0V2dsOEVpNFNoa3pNYW9q?=
 =?utf-8?B?RWxKWG1UcVNNN1hoZmNpYWJNRHVDRCtBaVZKWVpKd2tSbTdoOFZWLytodmZG?=
 =?utf-8?B?aEozSGZsbGZxZ2t5U2dSNkliYysrYVJlaERwSlU5TmQvQmM2cnhUZWwzVHRa?=
 =?utf-8?B?cHN1a0xJVGIzNGErRWFsTlN0eHJ6cnBOZmJ0dXpHdk1jbll3K3h2SG40NmZu?=
 =?utf-8?B?V3dtT0ZuUElycWFxMzUzbldQSFp5QW9YdmRhUEJ0RGRHb0NUN096K0NWWDlC?=
 =?utf-8?B?R3B2MFJyZ0syOTY3Sm9ocVZweHV5Q0g1S2tDT2RFQ3A4RjhBR3hPbWhIMkFo?=
 =?utf-8?B?cnNibE1IZ2ZJdFU5TzQwTmhOamdMcGZWNmJuekdlUy9GSHpQZ25PdkxidE1i?=
 =?utf-8?B?aGR1bGFvODJFdWtEQ2JPTTR1eUlQUG9vNXNKaW5BSi9lcUFWa3VxZnZGNjI5?=
 =?utf-8?B?NDlINm9PaHYyb0x2UlRMN3VGTFd1c2VsdlVONWtlTHU2cjBIOVBnd0hwRXZQ?=
 =?utf-8?B?dmF1MnRiSzZIODFsQ09TM21xTm5sL0M4TkNFVG5qV0c5QTl4NzJ4c0ZJV0V0?=
 =?utf-8?B?N3dzMkVWOWhoUnNHSXhQN2NXN3h2VFZHeWFWdWNTbTlNR1B6Z3BJckRFS3lx?=
 =?utf-8?B?Zm8xYlBXZjFCaVhvcWlIb1pVRkxMTmdGbEVDNDdPL1MwV01EaXlJUlhQNmJn?=
 =?utf-8?B?RGlaTk5ja1U2VEkrdXVySHQ0bSttWkVoeXhlc2J4UHdBSy9lb1pVNmtxUWdI?=
 =?utf-8?B?T1lrTmpPTStNa1RCWG5MTXRReDV2MVFzTG5Ja0FmM1BjNEZqblM5L1FCRy9q?=
 =?utf-8?B?bUxsSmNBL0lyclNWWllGeHpIU3p5NWM0aWxrWFRWY1pXTVlMZlZCWVhFWGxq?=
 =?utf-8?B?MGxGVXZ1dnpxdno1cHpUU0pHUzFOS2IwSjdIMGJkMTZ1ckdFaG5OQ1JYWm5w?=
 =?utf-8?B?aHVVQ0xzTmFLSWNoaklQcFpFZVl2S2NCOUh3L2VtRjQwdFdDNlQ0WmU1SnE4?=
 =?utf-8?B?cHIvd2FSS0wranhXS2xxOHIwYmtLNEVYU053MXFhZU5kVHp0RnhVY2FwaTFF?=
 =?utf-8?B?RVR3TjlFZWhXazNhc1pOVWFySlJFVnM1WmhUYUt4K242VlNueDhRZ0J0dksy?=
 =?utf-8?B?UWF3dk4rNWpXU2tBazRUSkZnTEsxWjlhdi9BWVh3UmduSjR4NUxxc0VlRUVa?=
 =?utf-8?B?c2ZCRWV3U2NsODFVcWVFYUdzaXBUd1N1WG5qWWVwdG83SDRzMGZ4dHkvV3lv?=
 =?utf-8?B?aUVZY293QXBZZGVKaHNPOERGRXZwcFNZZTVoYjl3TVBqMkRxWUJNVjBEUGps?=
 =?utf-8?Q?EGiD7F9wPeiNx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkRCcGl0b2xEeHFLOTUvckNuRThlNk84TWw0OU5uRUpDdzZ6cFUveG5LWVFp?=
 =?utf-8?B?UGFEclY1SkQ1NU9wNEhqejZ0VnhJVkVYRnJVa1hQUzNWckJhNmxUV0ZzdzdN?=
 =?utf-8?B?L3NlVCtDRk04R2xVUHVuZFk0eHMvS1VtRktkMFBTdEF5QWFXWGIydVBZWWVH?=
 =?utf-8?B?N2F5cGlnY1cwNTBSVVhRV1o2bGwySDZ6S0hGeTFZSEZiaWQxQVdDdzcvRlh4?=
 =?utf-8?B?ZW13QkwxVTU1LzBnNysxa01CZGxnd3RHSFY0eFo2THdybysxTEh3dWdXUWw4?=
 =?utf-8?B?dllRZUdQRC9GenlnaFFPVDFCZW1Pc1VuUGd1clBSOUZWWDJRME9pOW44YkhU?=
 =?utf-8?B?Vyt2ZFFJTEIyVTdIdVdYUTYyby9iekN2dklVV0VYU0ZpQTlnWWttdE1jVGxp?=
 =?utf-8?B?L25QYm9RWVhxTVU5RzZoMUNUQWlkOW5mcmJiRlFQZW5neHE5djd4amkyYStK?=
 =?utf-8?B?a09OREtpUzhKNm9vSkZNVys4dnlNOEdvbFd5YWs1YjE3bEhLMnA2czQvNDRC?=
 =?utf-8?B?MnBNaytCczlMNkd1QlROWi9IU1hkREJNajRYdWFsSWlkaEhLZWlVdk05RXFa?=
 =?utf-8?B?VzBtaU0rbk5NR0FlTVMya1F5S2hzeE5GbUdmM3h0aFlMS1ZERDZBVWlCeGpK?=
 =?utf-8?B?RWRJRkl0OUxncHQvSmdkRzRZZUJEekt2S3Z5MXpFUFRnOGR1RUc2L2xrVVYx?=
 =?utf-8?B?Tkg3dG11R1pjNTl0cklPTDk2dXliU3BUVjFERzJYZ0h2U0sxNjFIdDA3dlJM?=
 =?utf-8?B?SVkwdi81RGtSRUVnOXM5Sm16SktGclVPUFRoMmpyNlRTVnM3TS9BYjcrQlBC?=
 =?utf-8?B?SVVJU2hxVUwyendZY1FhRi9BZVFlVGVpQmVDOVVhYlRtZWxmR204WkFRb0dE?=
 =?utf-8?B?T3dlUHkrOTN2dGEyRjJNaDVrT0xBNXBabndmbVFBdU1BdW5HZ1pkV0I4Ym13?=
 =?utf-8?B?OUl2MmluekhKd01kUlliYWpVK0k3NjBjV3laV3BSc1dxNE1YeldwUUFKMUor?=
 =?utf-8?B?UTZYY1JIdEFwRnNCSk9WWVhQZkNybVNNN3VXUkFRaU5VNmRRamxsL2ZMeVcx?=
 =?utf-8?B?NUt5SFo3aXZxZXRmRW5RQlRXaXBsZTRxVFlHQTFjU2U3TmNTVElmcDBLckFp?=
 =?utf-8?B?UDlxZFIyR0NPRmllS2R4Y1hVRmk5Q2d2QVdJK0JxMDIvVFlqL3FyYUw2UVhW?=
 =?utf-8?B?WW9SdXB4bTcvakRFTUEycU41a1FVSkZiSXRpaDQ4RHVTeUMyR0R1R3l2bmxx?=
 =?utf-8?B?SjRMenFaV2VsRFVYc0xwTXA4ZitwSTYwbS9Nb0huRTZmay92cXJZMmJIYWsr?=
 =?utf-8?B?S1NmRkdHajlSWFZuczgxa3Jlby9UWHRzcEZPNUMrdGhjQldHMUEwOVlMRzgy?=
 =?utf-8?B?K29wUGRXYlFIak84MzNDSkdQaXhOT0dTUXB2a3pYYkhRdVEvcmx5dnNsbGk5?=
 =?utf-8?B?UmlhR1RESk55NkdST1ozT2oxdzVvZEZtNVhrQytxVFlmZCtpcU5uQi9IMVhW?=
 =?utf-8?B?a0J2UzZjUHg2bjdiK0hSZForTFJwMzR6VGNDTjc2bGNDbjFzUFJjSWxOV2tw?=
 =?utf-8?B?OUtCZm1LU0dFZmU4NEhuakNjby9JMmhZcXljMHpveFdwSCtHZFo1NFFUQ2Zn?=
 =?utf-8?B?SytUVkh3R2czZGxGYkFRano0OWpzQTk3dzNWemRMYzBwbnk2c1FEME40TWQ0?=
 =?utf-8?B?TTV3M2ZnQitHeno0cGRZSHpoTFJhS2VyNkJ5SHRDM3k1d1Y5TmZPb2lSMXFy?=
 =?utf-8?B?TURZcW9zeHlCc0o3dWFEQkVoZ2gvL2pTWFRKMVRtMm15UFpJZW9FdkE2akhx?=
 =?utf-8?B?UkRBc21TL1dKQWhSRnloUG1qWk5EK3pkTTVST3FGUGY5U0JVVE0yemphZjll?=
 =?utf-8?B?U0E0cHZvbTVkRTNROHpKU2dQNU1CTzlqMXpwNUxEdDhaaWZsZzAxS1Y0M0pi?=
 =?utf-8?B?bTFxbHBySmxEVnRuMU9wSDZYV0FOYjlHL1IxRW9INzBjS01TRk41ako4TktM?=
 =?utf-8?B?NXdDL2Zmb1VIQ0d0Z3hxOHdwSS82RnB5Mm5wbHl3djVtT1puMm9aOWJ3aktM?=
 =?utf-8?B?dVJwcGtwakRZNUxVdjZkZ0pKbDNsYWZVWTBUeE54N2Y1VHVWdnhrcUl3Qkky?=
 =?utf-8?B?a0dON3Y4Y2syWXl5MlBMLy9kQXdkdEFSMmNjRmZoZTNFT01OaE5tZ3JVbHFE?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04c1ace-ad99-403f-87d6-08dd776ef128
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:00:53.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5K5VrMQBr0EZQj4YsyXrgNfia6Jhoa2TqLjUMZhE7Ob7YnjY9oo9nSK0nCJKtKOcNF0WRj6RgPUXegGkzR8EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Apr 2025 14:01:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18499

On 09.04.25 10:26, Felix Moessbauer wrote:
> The Debian policy 10.5 states that symlinks within the top-level
> directory shall be realtive. Further, symlinks shall not be dead at any
> point in time.
> 
> We now make the symlink relative and create the target directory. While
> changing this, we also drop the unnecessary chrooting and make the path
> to IMMUTABLE_DATA_DIR canonical.
> 
> Fixes: 786ddaa ("Move content of home to IMMUTABLE_DATA_DIR")
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> I decided to add the fixes tag, as I consider violations of the Debian policy
> a bug. However, from a runtime POV this does not change anything (hence is not
> a bug). Feel free to drop the tag while merging.
> 
> Best regards,
> Felix
> 
>  classes/read-only-rootfs.bbclass | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index f1db4ae..e81084d 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -45,12 +45,13 @@ copy_dpkg_state() {
>  ROOTFS_POSTPROCESS_COMMAND:append = " copy_home_to_immutable_data"
>  ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_data"
>  copy_home_to_immutable_data() {
> -    IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}/"
> +    IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}"
>      sudo mkdir -p "$IMMUTABLE_HOME_DIR"
>      sudo mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
>      # as the rootfs is read-only we need to create the link
>      # between /var/home and /home during creation.
> -    sudo chroot ${IMAGE_ROOTFS} ln -s /var/home /home
> +    sudo ln -s var/home ${IMAGE_ROOTFS}/home
> +    sudo mkdir -p ${IMAGE_ROOTFS}/var/home
>  }
>  
>  RO_ROOTFS_EXCLUDE_DIRS ??= ""

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

