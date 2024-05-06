Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43657C4345F
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 08:25:43 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.80])
 by mx.groups.io with SMTP id smtpd.web11.15819.1714983933900734093
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 01:25:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WG+TgS1D;
 spf=pass (domain: siemens.com, ip: 40.107.6.80, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWe6OseHz0osU4O4FHy1En4+B3oPIunTpBYQ6ONIh/ksEiIAbWU8XmJtf6vhdl27bmS5bIIr94jt1Bkc4F4F7CGk9JrmRG5gDHJM37uLwaN0WdwkHtnbIAzjkAtTGowO4mMDtbsAtDGzLz75Wm4a6qGhlAFvJCvaL91p71AjY6rWAYFutWHACa8EdQbuVd3C8tANeEFY2b07qic4r62h53UsnJkaTYFNM419UCPWE3BSzfASCZPiFqUY8qxtSE8Dp4rCR3SsNlLFmd2NmPDKBIeQG7OsxcsTyHw3ezsCuUHXDRQ6TMij+RPj5MiSfu04PIHUAPPR1U4yYOK2UOZMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5WOM/f0wHiJBYHXd5YSY7vj3ZXCRMsLV8XaYojz7zY=;
 b=OfmSLGfulmNR8o2Vugo0Kv5rcaMDhpvqLZDgUR0i5mGtBRVOTzBKvs4ryBIxrfa/kGUthdThgoGGip/hZGRtA+6YSAigmncatH4Fq//2fw8D0tgSJv28LdE6q402/FWWH+EBe2m1hUbEvXpbPeJNyvMjJm23c47Y2usrOvt9rIjINgd8DFixOCN1RDBoGaOXLb/9/d9fSvrwLrGnXF1VEJcclWF6X/UbGAzCLb+2YoI3o15dgx2Q9E85JxxLHiOmWzwjPUiuJ5dHsjh8zdJ+375AxGkPszcc0vR+HEQuV2g/0EYkPnkcuBoRUz7dICRmLb50GWQCPCUhzh1ySNdx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5WOM/f0wHiJBYHXd5YSY7vj3ZXCRMsLV8XaYojz7zY=;
 b=WG+TgS1DxMHuto+IEHCIUSLUUUY2iIYngjBMjDnrzX3J0OeVZJdqSVQrFz4NIrUrUA1Sj1xMnkk5NePm3htZ+IeVenKyqZw0/VB0x1QYQLTgUg6hYuKGFtdhaHEq1PCWySrNMkli2eS/QP99xaVAECBxuTM44vQkwdw2Ep0SC6Vj4hyuFOEcf3Kfo+6PsVysB24+tLtJ6IejCGzUcWHa/mrbqd3cX5LRXIpkuWHO3FKbczg43awmAQdW0+8QeidF2IaFGgSEadnMLcAhsvPLEd3H3IOSA9IqUAXt+iKPi1eEFuc/PBWG/WOKdJbVKUyAwEqdxadIl/zDQboKpPmXKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GVXPR10MB8492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:25:31 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7544.036; Mon, 6 May 2024
 08:25:31 +0000
Message-ID: <e197cfad-fad4-4309-9132-f443ff0c0987@siemens.com>
Date: Mon, 6 May 2024 10:25:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v4 0/3] Integrate Delta Update
 with rdiff_image and delta handler
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: felix.moessbauer@siemens.com, shivanand.kunijadar@toshiba-tsip.com,
 sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GVXPR10MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d58017-edf8-4188-7437-08dc6da617a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ejk4aWlySFFxOThCYlNNd05EZUJabmhKSUpKSE1BOGdrRjVsRnhrRTBYbm9T?=
 =?utf-8?B?OENiTEJrRkV1bGFFZk51ZTBpeDBqL1pBRG1qWHdWelREZG1oRm1HSHExMTFx?=
 =?utf-8?B?RkpUTmJCa0ZmeUNqM2M0dXlrZHJ4RzltUkd5NVFaZnc5c2VpWHBLb3E2NnhH?=
 =?utf-8?B?ZEljYndGbkdiMDJzdGlTM1N5VnJUNHVEOSt2OWZCQllMREVlMXp2RFViMVlE?=
 =?utf-8?B?bmtpTHNMWlN5RENyM1dra2FSUFc4cUxrTGRTTC84cGdYbFVUeEhnaENpMm5X?=
 =?utf-8?B?cnJqeDc5QjYrQ0ROOVFBSlRFS0dwekZsZytOMWRXbU93cHdpOUZ1MU1WeEYw?=
 =?utf-8?B?N1I2TTNIeGlYYjF5U292MUtlaEp5OWxSaHg3T2JkRmdGb1pSVWdQK2RkZ1JR?=
 =?utf-8?B?VXkrMmVJTjV4bHl4TURtZ0lPblluc3hjMkdPRmlGQ0wvK05mTEtSTnhmSDJ0?=
 =?utf-8?B?N2FHeUdCQ1UreTk5L1JycFVKQWlwQWVpdTdwMTVxVE5lTHhIMXRFMXFKano1?=
 =?utf-8?B?RnM2a3VoTGJHRmVtbEdNbzZabjZJYUdSek91clVBQTNndFFoYjM4OFF4OG5P?=
 =?utf-8?B?UXBrWDJCUHZGMGZUd0QrcHBPUTFiUXkyUDdLcDUwR0pEaDFJTHBDb0xNckU0?=
 =?utf-8?B?a0xYN0Z0VFY2VGZyT2hwa1gxNklUdUFhcWVaTFRuU3NJdkNiNGlVYkpBQWhw?=
 =?utf-8?B?c1g1VEVIR2hvQ3NqeExvcjdxS0FxWWRXNmV4aVY3cEx2NlV3NlJuL0VYWHNx?=
 =?utf-8?B?S0QzUzNEa0JSTDUrRXM0RzU4aWlMb0Z3SVZDcmJvV2hJS2IzMVF3WUJXQnl3?=
 =?utf-8?B?MllDWkxjS2tUQUkvOEFWME1QS3FnOFY1M0doLzkvY2NId3JUaitCc0d0T29H?=
 =?utf-8?B?QnhUYUF6OG5EdDF1QnN4elF2dmpvWGJFSkxTakFLeHUxM3hqbHdPNDhkL0J4?=
 =?utf-8?B?YjFYYnhTZ3dmNHQ1R2FNeGhiZzNKWGtMWDRGT3RKMkk1cVFCOVJvZnVRd1Fm?=
 =?utf-8?B?MGZkZGNVSTROWGVCRHlpQWI1aHNQekdiaWVtc2xITlY0OGtOalkrOTNwM2ox?=
 =?utf-8?B?RHJ0V1h2ODhSWUtZSmxYUFJuaEdlblZ3Ylk2WkZKc2lPT3c1a2dzSUVjdHBZ?=
 =?utf-8?B?UkhFcWN5aDJmNExLTm4vN01LN0RGWjl1UUg2azhnbS91aExPRDFwa3dLTk5j?=
 =?utf-8?B?NDBMN0NpdHRiMndxOGlKWUpVcVhFZGZiaUI0UmhPMDQwN3BrenhBOWhXWnNE?=
 =?utf-8?B?Z0ROS05KQ0E3L1h3TzdVNnVqRmF4ekpycS8rcU9RN2FHamhVUDdCMnZiOWlT?=
 =?utf-8?B?VW9SOVRBSFV5SE1sOGhEVFN3TlBwVjJ0U3JHQ0RPT0FQc1FzajdEbnMxTnFH?=
 =?utf-8?B?aFNOcGVzOTB1WjVXMHAwTlI3Q2ZqdnlHTjNGMFE1cFlzRWhJdnk2NWozME9Q?=
 =?utf-8?B?VE1DVVIvd3BiUGxYRVBaeGtweFJkRTREb2NXQUhUcitsRUxxQWZqVE1meUc3?=
 =?utf-8?B?NDNCY2FFZ01qVHRXZUE1L2dyM2Zsa0lLazFoYjNRa0VReXJkdmhCRG1ES044?=
 =?utf-8?B?UGZSS3ArK2k1d0lTMDRkcGpTbk9FOGh5bWxJVzRZWUw3MEpGVCthb2YvUWla?=
 =?utf-8?Q?n8a46s441zwyxK4WgT+shGAviP5kb1hHD1guzPIATU/M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K3FwSWtVNkZ5OGtsd2hiMVZETVBLZ1J1eVdXKzAyL1o0MWk5MW1oWWlURmdP?=
 =?utf-8?B?SGx3dVVKdVNjVUE4TFI0bTBXOFNJdmVuTzU2YUVEZjVyRUN6czZObHRtYWFO?=
 =?utf-8?B?RUxqRzVlTEFvWWxKZkpHcGVJZ0g3Rlp6R2t1QTlUYUtRQzFuc1lLbjdIb0hB?=
 =?utf-8?B?TTEreWZ0Z1l5eFVYOHpXZm00enlzaDZ3d3JtdWlpZUNYTmJtRmk2TkYybE9F?=
 =?utf-8?B?UFRRb3c2UVprbENWSkYxRU45Q1cyWmZ2dVF5ZHVBbStEaWd1eCs0bVBLUDdo?=
 =?utf-8?B?MEdvZTlvR2U3QUtNZUJzU21UMTg5N0pVcU1kRDcxek05TDJFV3IrTHUvMnM1?=
 =?utf-8?B?akVzSHpvV3RsQnFxSGZ5YmcyNU1PNlRrSGlyY0NwemMwdElYV1o2SnhRNE5v?=
 =?utf-8?B?TUpLT2tXc0JiNTY1M3U0cW9jYWgrQVFSQmJDYXUrR0RqK1hDOWh5T2J3R1VD?=
 =?utf-8?B?bTBOTGc1dDhHTUI3UEJISmhUY3Q3V0dFUG1YTnpPUGdqbFZlRUo2T3JZaUhD?=
 =?utf-8?B?Rkg1U2h5Z2FWVmZCRTBaT1dtSndsODNSdFVvTlRPZ053QkhpbFdVNmtTSnZG?=
 =?utf-8?B?OEVYaGVtSVVjaXRONmpwd2ZYV3FoYmpOcDlFYXZKN1VSa2Ntem1zMUw5d2pG?=
 =?utf-8?B?YkYreTFrQ2xoSGVrTW0vTU1oQllramlRcGNVaGpLWloxME0rN28rWUU3N1VS?=
 =?utf-8?B?MGRIYWhIY0dUQXpydy9nNmJ0NTNzQVhwM1ZSbFpWTmtQa3J0STY2SDMxK2E3?=
 =?utf-8?B?L3BvMzI4c09qTitxcXl1MDlNaEo0SldrWFBzYlNmSGZ0ZVNSZzVVRXVSN1RX?=
 =?utf-8?B?anpNVmpONk9UNnEwT04zQ0tFYklaOWRMSGd5VmxRNmV5YTQ5U05WM1ZBU1VD?=
 =?utf-8?B?dkg0YW16Z1VaYkZnRzhVeUFWYVpmUml2Um1mVUs4L2lTZXU0TWtwbDBRT0dx?=
 =?utf-8?B?bDQvUWpmNXdSM0VrQzNUUmI4eXZBdW5aVnRyUU5YdncyK0tlM1lZQXM4NVJz?=
 =?utf-8?B?dkRqM1ZWc2lOaHhoMENza0xMcFhNQlBpMUkxazZMNkhFQnpnNUVJZk52QXdX?=
 =?utf-8?B?S05tUE1mUUdzUVdLRnFpeXMvbkkxRWkvSmtyY1FrWnlKbCtoNndsZjQ1U0pQ?=
 =?utf-8?B?RnExNlNRcjJDeEFKYnpFSW8veUVMbGk4MHpFL1ZJZmRuN1F2V3U5N0tvaytD?=
 =?utf-8?B?TmY5RkpRNTNHZkFuTVBxT2laeUdDMmNXZkJTSlpCSUZETjZTUm9KcWNjcmhU?=
 =?utf-8?B?VzJBcXNZSzRiNy9sZlo2eXZyNHRFQW9iNDFXV0xGYlR6bEJJa0FyVW13bUtu?=
 =?utf-8?B?MUgwekFBOEV0dFczSUo4VVMzVkdQZW9BV2FaL0tyUUNTdXorbC8vejVvYkFR?=
 =?utf-8?B?RThtMHpvdnQrQmlweUloN0dZaGdlWDJUZkFzeDhabk4zVHh5eEZyckJKTFZM?=
 =?utf-8?B?L2VaZFF4N3Rkamx1TGwvTnhtYU9GM2RPUUROMVczSGZqaG9Sdkp4bHNFbno4?=
 =?utf-8?B?WDA2bUdodDlHN0NGcExlcEZVWUgvbGpzeHFXTC9MOVVoUGtjY0puM1hPVndm?=
 =?utf-8?B?UE5oSzBmZEtxREVIb0NNSlF2dU1CYW9uVDVZUUsyVzdYN1ZpOFF6dHJiMUo2?=
 =?utf-8?B?Z1hsZXVMSE13V1QxVXBFMHEwekpHeWJlVEVyYU1qS3FoNkNEcE42ZTZneVlG?=
 =?utf-8?B?VHlaTmJxcnd5Ui9uVmJ5OSs2aGsxNmdrYTN5aHNaMzRmeGFWMjFkbGIzb0ti?=
 =?utf-8?B?NldNYWVIVGxrVCt3cTZYRWZWai9VL2RzVkVVSStGQkJQVnNmZ2FscWZtQ3ZF?=
 =?utf-8?B?VkdtRGxtZ0hWWEM0ZVByelI4cVpNOUtvbU8wdW50ZkZSVmlkZkpXL0tkTFNZ?=
 =?utf-8?B?YllKYTdZWEJlTlB5YWN3dkpETkhBamlmWWRPYnhwWW5BUkdMeGVBc1JyS0ZH?=
 =?utf-8?B?U2t2V3JoTExVSTlmUU11UUQwd0JUaGwzYXJhdnVMU2JIVWFBWktCalM0bXBt?=
 =?utf-8?B?YkY2b0FPWnRuVm1ic0kxL0dQcUNJdlhoZU9pa0ZqQ0hRN21oYWVzR091VGgw?=
 =?utf-8?B?cGJiOUFqUDlPQ3haQ3hTeVpVQWliUCtLSVJkMXpNdUd1Qkgxd3FPdU1RMU55?=
 =?utf-8?B?OHhoV3ovQllkWlg5c1NDNXNZSGRWdWxBM0ZKQ3NJclBRaVR1dTdzRVV5VHB0?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d58017-edf8-4188-7437-08dc6da617a5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:25:31.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43YI5EUN31lER7JDxv48Ly6prXY4GQNW+j9c1ypG1xw9PbKhiUIvdl3xS0OXfLHCD8FT/33McKVrgqGDm+5NYh0Xp/TawFxhjQC4IpHpG/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8492
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 08:25:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15826

Hi,
is the patch v5 in work?

Quirin

On 4/25/24 11:44 AM, Adithya Balakumar via lists.cip-project.org wrote:
> These series of patches enable the support for delta update for the root file system with swupdate's
> rdiff_image and delta handler(zchunk).
> 
> A couple notes about the implementation:
> - In this patchset, Delta update is only supported for the root file system.
> - The newly added delta-update.bbclass handles the creation of the delta update artifacts.
> - The update handler type i.e rdiff_image or delta handler is set in the variable "DELTA_UPDATE_TYPE"
> in the swupdate.yml file along with some variables required for each handler.
> - The creation of delta artifact for the rdiff_image handler requires a reference image (against which
> the delta is computed). Currently the reference artifact file (.squashfs/.verity) is passed to the
> build system by placing the artifact in the path "${TOPDIR}/previous-image" and setting the name of the
> artifact in the variable DELTA_RDIFF_REF_IMAGE in the swupdate.yml file.
> - zchunk based delta update is only supported for sid onwards.
> 
> Changes in v4:
> - Create only 1 .swu file, either delta or complete swu.
> - By default complete update swu is created.
> 
> Changes in v3:
> - Rebase to current next branch (61e998e1e0541e2713c05fcbf21df39fbc882a0a)
> - Set "${TOPDIR}/previous-image" as the path for the previous image artifact for rdiff update.
> - README updates to verify delta update.
> 
> Changes in v2:
> - Removed zchunk support for bookworm (due to use of backports). Currently zchunk based update only supported in Sid.
> - Removed delta-update.yml file. Related variables have default values and can be set in manually swupdate.yml file.
> - Using .squashfs file (.verity file in the case of Secure boot) for rdiff delta creation instead of .wic file.
> - rdiff is set as default for delta update type, the build system looks for the v1 artifact in a default path (image-v1/<artifact_name>).
> - Created a separate template file for sw-description of delta update.
> - Renamed delta_update.bbclass to delta-update.bbclass.
> 
> Adithya Balakumar (3):
>    Add Delta update support with rdiff_image and delta handler
>    swupdate.bbclass: Generate swu for delta updates
>    doc/README.swupdate.md: Update steps to test Delta software Update
> 
>   classes/delta-update.bbclass                | 97 +++++++++++++++++++++
>   classes/swupdate.bbclass                    | 27 +++++-
>   conf/layer.conf                             |  2 +-
>   doc/README.swupdate.md                      | 59 +++++++++++++
>   kas/opt/swupdate.yml                        |  5 ++
>   recipes-core/images/swu/sw-description.tmpl |  5 +-
>   6 files changed, 189 insertions(+), 6 deletions(-)
>   create mode 100644 classes/delta-update.bbclass
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15747): https://lists.cip-project.org/g/cip-dev/message/15747
> Mute This Topic: https://lists.cip-project.org/mt/105727112/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

