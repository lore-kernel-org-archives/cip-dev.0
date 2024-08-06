Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D0C3DA7F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 12:04:49 +0000 (UTC)
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web11.21620.1722988127867552146
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Aug 2024 16:48:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cybertrust.co.jp, ip: 202.241.206.55, mailfrom: masami.ichikawa@cybertrust.co.jp)
Authentication-Results: ss11.sbt-mailgate.jp; dkim=fail(No signature) header.d=cybertrust.co.jp
Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masami.ichikawa@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id HIuk17111A;
	Wed,  7 Aug 2024 08:46:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LplTXwCk8AMrjuCGsS7dOvGNHPYcBUXU/CsJWYkM3PCe5n2UofTbJGsZntK7ruFB9In0IuYTN7coeW59zY0P2N0IGN98EYStt1YS0XikGeOKxfTmWFAw/IRgYuyfTWcuhjJdu51c/uv41MKOS9maMfxADPEkb7r9fmpaP1konhmIHyvdG6gDRdRQ/2FJbWaEDhVyJOnY2QRASfCRttA/ynDO2ltE1aZlNacwl2MdlAIICeFP6cG+bVtTT8bTmp1zx/irh/xWw2D7d6koDTyAxnIREQ8dNmfL75td+rHBb30ALm6oNMSITKxTkKUDcITUy7TmafpWYfPj2EaqaexmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaSJrsqDPlCbaYBmQZha8DWN+6gwxqbxUra+mXlFn+0=;
 b=i4imD3Q11O/lu1ZrBRG51bU4Z/tfoVNjcuG/Jh8l8MiGWfL+jcc+YZGXEE2NZz13nnHRYXPShPDeoLY5N8xlR2VxylD4rHg5I5E6RBYlPuM4tUBRCNcUBN3khy+GgwFdpdWGmNYRYWTd01EzqMJuemrqz1u0IMpCmJzsjfRUuSObd3rxa2o/lxqCOFzi8SdF0G+FgecRE8snaQCncmvdVB56Eh0SyxmniU8y1vmEr6AdxsoYyMh9JSBriSIwqOdedXDSoVTKJV9yctTomNrj1srJWkT8WGcSKPkumVc0ov5N3DROw7B8np/73+PbU5YSzpIfjFiWgfh11s4L7zR/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
Received: from TY2PR01MB4044.jpnprd01.prod.outlook.com (2603:1096:404:d7::19)
 by OS3PR01MB5895.jpnprd01.prod.outlook.com (2603:1096:604:c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 23:46:33 +0000
Received: from TY2PR01MB4044.jpnprd01.prod.outlook.com
 ([fe80::e364:f999:3bdb:ccec]) by TY2PR01MB4044.jpnprd01.prod.outlook.com
 ([fe80::e364:f999:3bdb:ccec%6]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 23:46:33 +0000
X-Gm-Message-State: AOJu0Yx8SKFyEPs0DMavR+F4xM5fWhb9tWPdWtdh3qS6C8xBdYPcbSnb
	AFGNZ3l4JXF8Y/+cM9YZUDXfuwC7lBVz/+faD1AL37Pj0lP4Z+fjfYD6S5T6P2GoAhpTotUB9zP
	0R9aUNJTtpYT3V4vVmvoZlwodg/0U9wQy7u7pHQ==
X-Google-Smtp-Source: AGHT+IHiBM/hShfEvqusDc1LMqZpQ2RuUgMruCvF7dKr2hxkFCtI8NahGa4h+ljtzUBlWSfm+PaGnAPqPDX3Cjl3/IE=
X-Received: by 2002:a05:6512:696:b0:52c:9f9e:d8e3 with SMTP id
 2adb3069b0e04-530bb385bbcmr9924041e87.31.1722987983336; Tue, 06 Aug 2024
 16:46:23 -0700 (PDT)
References: <TYYPR01MB124023222835A195286BCC954B7BF2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB124023222835A195286BCC954B7BF2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@cybertrust.co.jp>
Date: Wed,  7 Aug 2024 08:48:42 +0900
X-Gmail-Original-Message-ID: <CAODzB9qZWCvX3oTx0AsV2SwLUm1LNTULYJbzTvh2Cu+as4vsaA@mail.gmail.com>
Message-ID: <CAODzB9qZWCvX3oTx0AsV2SwLUm1LNTULYJbzTvh2Cu+as4vsaA@mail.gmail.com>
Subject: Re: [cip-dev] CVE-2023-35827 tracking
To: cip-dev@lists.cip-project.org
X-ClientProxiedBy: MM0P280CA0015.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::20) To TY2PR01MB4044.jpnprd01.prod.outlook.com
 (2603:1096:404:d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB4044:EE_|OS3PR01MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: c831d6e4-a151-421a-cd9b-08dcb672007d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|4022899009|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFAvQktyQjJ3T0hiS0JLelZEQ2ZmT0VZK0I0bUE2VlFhaUlIRnZpSGF5eXhj?=
 =?utf-8?B?YllNaENRREdyaGtsN04yWHlmRTVjU2FPcGdVZjJWTG1tQnJXM2RlWnRMNndG?=
 =?utf-8?B?SnpFdmRVcmt4WGxoY2J3T3dpSXFVSFlxc01HU00xUGtBMTA2RHhuR2FucHVO?=
 =?utf-8?B?S09nYWNLcyt6RHNKQW9FMFVIa1ExNHFGQjNXd2Nnejl2QlFkKzdxbkRtL3Yv?=
 =?utf-8?B?ck1Xd3l1M1IwWDJSQjhGaWlJQVlnU0trdjRMQXowTTRWSzRhN3h3L2hTR25I?=
 =?utf-8?B?NVlPZWVYMmxpRUdhN2ErREZCNk1Uall2N1g2RkpTckk5NjZBS2x0aThyWGpw?=
 =?utf-8?B?TzZ5bUoweXpaUG1JUWpYR3BTbFVmb0lETy8rOUh5dktkQXo3QUx6WXBTMko3?=
 =?utf-8?B?c1V5NXU4OElDdWJRY3lMWWFUU1NJUmNZR2VSZE9YVENMUVR2MWQrNmk4WUd5?=
 =?utf-8?B?MzlCZDExb0FrUnZReHJsSnpMVWN5b2FwOXVkaWI3SnJockJ2YmJhTklLbjY0?=
 =?utf-8?B?WUNnWlY2Zlg2a1g0eTc1SG5HK3pZYnh6c3VkcGtpSGkyVmlIRElVQ091T2lZ?=
 =?utf-8?B?OHd5SEFkM1g0SUVsNC9LVGg2d1llVHdGNTFPSDkxektZd1BvV3VMSHBnVHV4?=
 =?utf-8?B?QU5CRHlJYlc4WS9mcWpIeGRYOWxWMjZhV3locWI4VmR1TDVjR0FvSEUwblBt?=
 =?utf-8?B?Tk5vWHc0Ylo3enY4d3NHY0lkOUl2UWhDL0MvZWNGQkhrYVp2elp2NVF4djhS?=
 =?utf-8?B?UzcvNFpROWJuTlBoVVV2K1FIbHB0T2g2ZklmaG9sYXBMN24yUjNBRWYxRWpW?=
 =?utf-8?B?dk9zdzdpbDN5RysxdzlBQWs1NjNoaDNBbGVhQzZkV1VmRTBHYU1WbXkyaGRn?=
 =?utf-8?B?S3l6aXJQMlZ3MEwrb2RrVDUrcHBTQlFZa0x5K3NNY01HVFhwbEFMNHRaTU5p?=
 =?utf-8?B?Y25wbTBib3l2WFp3dlpvQmFYaURuYnArdVdROEVQRFVVWTZnczUwcUdCc2RI?=
 =?utf-8?B?S3pqL1NOK0NrUVlSZ2JhY3FuRjlVaXJUT3o1Ni83c3NWckM5bUVSZlJsMFB3?=
 =?utf-8?B?TnlybzVvLzJQVitTRzBDRURUSW1YWlAyYWEva1IxL3FUN3Q1L1VNZXlpL2pn?=
 =?utf-8?B?TmVzOG5YbGxDMUltY3ZVNENoWndrcHpMMnlnYlJFbExPaFcxVDVrcFFQZlhW?=
 =?utf-8?B?VGR4MEN4Ty9yVVBHZGZjL2RlQmNHeTM3MmdGS0pEVGtiNkM4aFgrc1pobFVY?=
 =?utf-8?B?L0xFdlVwOEM4YU9SNEJjaVRFWm9zT3lFQW5ndkdKQ1JROGhOckNnQWZydWN6?=
 =?utf-8?B?NEZTWUl1TmdkbldENXZsSUl2WjdOTm91djhWYzMzbVNTQjcwRnRreE51RHBI?=
 =?utf-8?B?Vm82emxkRGtyRmkrR0hneUJwcjVCUVc0ZXdBeFh2Vk00VHVRYWt2bXZYbUEz?=
 =?utf-8?B?ekJaY1FETS9RWjkrTFhCVW9GWHBybVQxcUU4QlQ2UzFFallUYnd0akwrN0J2?=
 =?utf-8?B?dXZUckd3WnBQQURlZTdjK2tOdnQ5TWhCWG9nYXArdFhGN1AxNHZDQ0NEd1Rm?=
 =?utf-8?B?UjlaUGFPZ05DQVNVMXJvRFExWkxtRTNTUmNMcjVkTzc0OXdXQUVZVlFYM09M?=
 =?utf-8?B?YVkwbUpsc2NteXRxSDBhY3NWa05ReUI2ZkpYaEZCS1cvclhXeWpaUjBqTFUv?=
 =?utf-8?B?ZG81NGdrZmlkUkpjS3lGUmh4TUVtVGJLRWZERy9GR0JUekwyVE03RHZYb0xR?=
 =?utf-8?B?KzhwK0JMdk4wemdXNDk0RDkwU1Yydy9mR01qdy9XR3FDQWozTGlTaXg0MXlV?=
 =?utf-8?B?aUlwbURkY3ZYSkJuYVM2UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4044.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ay9vaDdFenlVWk0raHZMQUhheXhOTmdNYTQva1N2V2hUUDJtN3JEczZwRjhO?=
 =?utf-8?B?bUE2OHIvaFRrR3ZJMFZuU0V0dCs1dHczQTZ6M0tjNU1uaEFjNU0wR3BZUERa?=
 =?utf-8?B?YUMrdjNmd0hGZm9PZS9HYlQvOWdQUG5LbkFhYnUyNDFsc2kwNUd1YTNzeSsy?=
 =?utf-8?B?TnZRWEY5bG5rZ2l3dnZCQU91MWRYOE1wVFhvRG1WYXozYVZwY0NDdlJlKzcx?=
 =?utf-8?B?SkVqSUtwa0JhcFNqYzNNK1V1MHluTjE4dEw0R3lLMkVndkVjVTFXN2lnTEds?=
 =?utf-8?B?TFl4cEw2THRveUZKU09BbTEyWWdhYzBRa3BPNmJ4cDZKR2plTmdEZGh0V0M1?=
 =?utf-8?B?aFZlRVNibHVNMkVJaHNhUEswUzhyb0krSFMxVjRhVHlSZng0UVZ3c3QrZTE4?=
 =?utf-8?B?U1M3MHg2N0FwT3JiQVZEQUprOWVrNDVkcTlaODIvZ3diWnlSanJSdG82UEw4?=
 =?utf-8?B?UmUxZVJvL3ZoMm1YUE1YYmhvVUhDSGhubnBHL2ZDTEtoQUFEV0pZVERmRmNT?=
 =?utf-8?B?aFlaU05OZG1ueFRWMlFSeTFrM3hWdCt6RHZKRHZnbHJOSTVsOGVYRkRtYTZn?=
 =?utf-8?B?QTNGdzVxa2EvbFczMGoxdnB5YTdrMjkwVGdUc2d1N3A2MS9GdFdVbXdkYkpQ?=
 =?utf-8?B?K0N0VzhrdENESDRBTWxGNjN2Z1RyWkxHNFc3cjYvZElQZEZpNXBKbzFTV256?=
 =?utf-8?B?aktiTTBTdkwxU0s5MnJsZ1NzbWVoVGtZMllrQ0ZlRkcwTHhGcDBacE5mMGFK?=
 =?utf-8?B?cHRnOElrRkhjS0Q1cVdpcVJiRHgzTGNDM28xMXVsZnpkZTZjUG9xWHNGTEFO?=
 =?utf-8?B?VEZhSHJRdkxNanFTVi80R0plSkw0NlBxTjREbFBKc01lN09EV2Q3cW9BOFh3?=
 =?utf-8?B?OEFDdGk1YjFTMGxxRjJhYkh4MjhiVzFvd3JkUWR5WVl4cWJneGFqVG1VWTZY?=
 =?utf-8?B?MVFubjlESXViS0ZRSEZDeGxxUG9WQmlXWVg2K1VVSnplZUxsMlcvN00vKzdS?=
 =?utf-8?B?bVM3Zjk4MEZ3S1MzN1R5L3FjRHpUWDZkTWkrUWVUVVZvcnYzT05heDl5QmFQ?=
 =?utf-8?B?azM3azFOSTJ0VStVbnVITXhnbzUzNnc3QXdMVjZObHcyWEgwR1djbHorUEJB?=
 =?utf-8?B?WUZRYUR0WklBSC95TzdreitvSzN0YXpOK2JZdXdrOTE1dEFndTByV0p6eHNT?=
 =?utf-8?B?TWREaFBiUDg4MXhCNENhTHB4NjA5SUFuanVjcXJpQ3N1NnpsQThscFo4RzFG?=
 =?utf-8?B?NEVvU3BIaXVmaWdOTW5wZzQ3U20rTmJRbElMdnZyeGFQMzRvU0VnSmlqSGxi?=
 =?utf-8?B?clQ1MWlZS2lUU1RkaUhtc040TXRoM2pvdlFuSVNPalNGOWN5VEplaFV1MFJp?=
 =?utf-8?B?b3JoRHd3dTYvZ2J3TFBMYmdOTnR6RlY2cWd3K2xsdytDTTBzMk9hRjlDWHE3?=
 =?utf-8?B?WWx1OURQM2ZQVDBiTXREQ1M2V1lhZmJlb3grN0p5ZUVlaUJRRFlDdWEweWRM?=
 =?utf-8?B?TVdSYy9MV0pWWm9EUGNveWgrUGhyRHAvcnFITEY4Z1ZmQ0p0RGtWNDMvMFBQ?=
 =?utf-8?B?NnJuaXlpNzZUamxQMTFXMEJHWFA1aDdJaStyM1pNak1Yb1VDWkRwcHNBOVdQ?=
 =?utf-8?B?d2tSamtDQkt2djhsT0tuV3E3M3RzZkFpT3k1RGdNazNWWEdPbFAxZTlJczZL?=
 =?utf-8?B?N25YekF0eWRuWGY1WExNTjRtUjdscDNibVpnREoweG5wWTNuWGVjRmhJa1o2?=
 =?utf-8?B?WDBEdEtWMXRoMEdLb0NhVW9ENkVjL2N0VEZRaG03R1FlaXdrNitkUk9weUc5?=
 =?utf-8?B?WjhsVGNIZjdIZEFJYmYyYjVkZEpnSjdMeG9aRmRmVU53U05HWEdSNGVUekdx?=
 =?utf-8?B?U0hsMjVxMk5LY00vM1dndjc0SXFkdGdKY244ZzQySGlQNTRPN2hoa2lpZVQv?=
 =?utf-8?B?LzIyVEd0N01DTzlJcWMwZDROUlNYNzNoVWxwSFlWVzVpS3lIWGgvTEgzR3Yy?=
 =?utf-8?B?ME8zaTN0NGVJNjlTRDBkSkR6aW51VTJEaS9seGZxK1FMRlZIMHFxUCtJZE1T?=
 =?utf-8?B?a3Jyc1MzVUsrQ0xNL1krVmdscHBPQzFybVpSamdVUCtrb2xsT1FaSmc5elQr?=
 =?utf-8?B?YnR6S1lLQ3lVNlMyRi91enB1NkcwanliU3Y1NjVaQkxKYTVIVlF4Sll0TTVI?=
 =?utf-8?Q?DxXD7yDDuyDlf0ifxZPO4U0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VQm/tklbJgXSKlvo7vcvpleG7zGJlKPcIXRW6oowhl2B2muvDfq2eP0OrUkHJz0pa+zyrOPuCpkIFxGMuUtnhvFo9Z/WQlvJrwEJHHECA3lYJcyb6Ac7bJfg+QECW+se8MDw9bTRMG85GLxFcb8jqgLeCqjSbJlb0GQ9FHHqAtkhO5Br1798FjTrmw8u4uk3IZ6HQDFR0QRIzr5DaUdQshTfVZrX4RvNagf4iLQ1WCKvW8YwwGBBvQbh8ig7KocuZRUg2B3uVdcqMYeCfh5zxFfTFHXRIHJ2nPSv3OE68EZ8ouOE6KxDjL7xyYxVY/8GfTJe7ss2kIKOqvCt4HFTOObCNaDjLizcVP+WKIYgT5oD/Ln9ag0psP4XCFPB0yMUFe16FfiJIEpzYXOtg37sfDJXkUf5lSaLvb0iG1lIfUB7K2G6e+QAla+PSD93UsPKO4Y8XNdQyXN99cZcnvbOUjeq6Ij3V1PMgYmaRh5cDVvS+TC/SmbC8GCZDs9T4BBaIkhSUBYkKjNe2n3mmCpz693LYGsqYcZPVzUuNSYnAmKinaUepQ5kHwMwZuN0eA1y8Ui4yaRyRGXuMB4jgFIMjsBdKXSNVxyvmivuQT1qy9z/XKrbelHMNV2MArzsIlj7
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c831d6e4-a151-421a-cd9b-08dcb672007d
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4044.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 23:46:33.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37BjnPgB5uBGwnhey1IQrVtvOETqzabCXJMTlU3zOvJTz/sRYOQq6e4sGwEtLdcDMpPyIvhkcMJAHGCM02S3rrbTtdABLVbRCly1GQxpWHaxeERFgdGLFpGUDsg2df+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5895
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Aug 2024 12:04:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16757

Hi Chris-san,

Thank you for reporting this.
I think I made a mistake when checking kernel configs. I confirmed
that CONFIG_RAVB is enabled on defconfigs in cip-kernel-config
repogistry.
So, I removed the ignore block from the CVE-2023-35827.yml.

On Tue, Aug 6, 2024 at 4:29=E2=80=AFPM Chris Paterson via
lists.cip-project.org
<chris.paterson2=3Drenesas.com@lists.cip-project.org> wrote:
>
> Hello Ichikawa-san,
>
> I was just looking at CVE-2023-35827 in more detail.
> According to our tracking[0], the issue is already fixed in mainline and =
CIP 5.10/6.1, but not in the older versions.
>
> For some of the CIP versions there is an "ignore" for this CVE labelled "=
No CIP member enables Renesas Ethernet AVB driver".
> However, looking at the cip-kernel-config repo[1] all the Renesas configu=
rations enable CONFIG_RAVB.
>
> Do you know why this "ignore" was added[2] for this CVE?
> Note that I haven't checked any others.
>
>
> [0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/blob/maste=
r/issues/CVE-2023-35827.yml
> [1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
> [2] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/commit/004=
2abd91f2dd701c89c5a0bf681268df8a5c5bb
>
> Thanks, Chris
>
>=20
>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

