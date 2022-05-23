Return-Path: <urs.gleim@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06F7C433F5
	for <webhook@archiver.kernel.org>; Mon, 23 May 2022 12:46:04 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.70])
 by mx.groups.io with SMTP id smtpd.web09.27234.1653309954404667478
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 May 2022 05:45:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n8tYIQFN;
 spf=pass (domain: siemens.com, ip: 40.107.1.70,
 mailfrom: urs.gleim@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikuBHs0LApjsAyYOPvDtVNj8ysWY2uN1+hl2KW0FJ+TTr1Nfw8EXlFszeEAAjttqNfW2tr/L2PxNwkCQ7ckPk6flN0USiXER3D3pKpVMEhvCOvf736sKYcDkxjed+8/x2jlim7u9gM1KHsZy15DhBqARR3Na7CaLa7KuY/HWwEupnGoIuZlhuTcxNJ17G+Y/KMT1B4NmE/wsIodvcNUuTmnJ4D83375a7h1JZMOjpf+rKYv40A9Q2kGYpYQs5xl05/Dh8qsOk+qVQMRwUxAT9Hh5L3l9c8rbnJBlanPV7Tf+E4udp6+rvX4vYLhAp3xifJ/DJ2eREzpQM3RC452iAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWXmiHc8oYrPgZoIDf2M/2jwmmMpU0LZbrW5+k7gb8k=;
 b=kXCam/Flz7TB2oHCaOZC8LT7mqzW9wO5dxAnV8tA67/3wxB4eI/sC+biT0Vt7uCj1jlkzhdTOizDXOBwTzCdjM/S2khis2O3G3UeEqrmGA96Vu9G1/FGHLxE7eX9rwmykKANizZVjT9QkCP2mrFTG3owCYq41KM4v8iesikA9ESx1v+xAU3hJROSvT2KfmbWcwOFnq/oTM9OGr0jlvmNnICBmUDK3egzAI4my4oFOLwbrYhRMyELprS6lJanm2OZfT3cX7FaIhYDhjp7S0C/HrtYB88K5/b6vAFDv3kHBcewVwJZEbl/pTNo4nro/jakBbP9h0F0Gxcn6Nrsm06RVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWXmiHc8oYrPgZoIDf2M/2jwmmMpU0LZbrW5+k7gb8k=;
 b=n8tYIQFNk9dulx+FrPC35uTZ1KzJQQ6fWaU2YFM0c2cs1SrFTrx1PwN1CzdZeUVDPfuSJYV0G8G6Lc+czX/UnwwAGk9jZ3gIJ8sprqB6xur8LGBgYpit68Ktoo4OV9+ikykBS4L9s9Q1DFn97QdVmQIKlkOrzKxA1v6w7yP4FnhIrYj000O6vWUqGM7OnoKYvvX/CoJ6g8gn1mqQQG2p2OWj6b2RAvQh250E6P9MJ7T4DkstT7vJ/TPrhRzyYc+Z8l7tz9p+LaJaeZkJqnEjBGhX7cQttsWDzBfuaguh/KSgBPbcLoiRH08U37FHZ+pcMBIOTwcgQVFggNhZqSt6JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::12)
 by DB9PR10MB4778.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:23f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 12:45:51 +0000
Received: from AM9PR10MB4197.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1cf2:d55e:5903:5892]) by AM9PR10MB4197.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1cf2:d55e:5903:5892%9]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 12:45:50 +0000
Content-Type: multipart/alternative;
 boundary="------------Z0N8j5Gm0jMK0CDxi9lSZ0vy"
Message-ID: <36678b82-609a-af73-4ac0-fdfddaa21cc4@siemens.com>
Date: Mon, 23 May 2022 14:45:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>,
 cip-dev@lists.cip-project.org
From: "Gleim, Urs (CT RDA IOT SES-DE)" <urs.gleim@siemens.com>
Subject: CIP talks at OSS Sumit / ELCE
X-ClientProxiedBy: AM6P192CA0056.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::33) To AM9PR10MB4197.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1ff::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1887100f-b3ea-4f25-7376-08da3cba2aeb
X-MS-TrafficTypeDiagnostic: DB9PR10MB4778:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB47785CFF3EED57672B9718B5EFD49@DB9PR10MB4778.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qYWBSDANNvjep5BDtJ0cd/uBdTvgFNbHP/Bm8x79bYI2BC8AyUmu33Il4NNSpXuJuvvrwnvOlrzgSdTkTP7kblGhZKPjf+Dd6QCNhka3uhPO7x0J3RnEOcngGl5yiy8H9OLjajmuQzhYaLZZL+kgWVnIP+uW09F6bHWFjFoLAEmaFnsdaraJXlgwM405nGfEwnzLISDgQusUGhGEFZyJWlw3WbdoXKfwXPKiYVc/nAcPWQXSVCe/SEDTBlXq1gbVqk9QL6hJ51B2AqR1rIbxe+zHiRGwLyxP3zaNeynYh8poDuDAF9AXEsnZFssZcGd3KKcvm95zRnlEKTxhP1Q6TgBL6yiWV65FgHeCGncDHv1jvRsHoyRYkv4uBqn69rX5QEBiA3nWBEvdc57oxHNLGA5TBtF0JO3SEbmdyJh/TxjZ8OBxUpJJHOhwXhubJf1ceCGKCmKfuOf5Y4nns3RuQi8+ZjT6CZRNv0otLMD/tPZFMZ1ApAZfwTmtNJB20rvO9c5nFWq08YL4Mwl1ETAUCGQsyymufF1lPYOLzWze46dPbEE7dlmgicU18GDykZWnHKnwVtEjIIdoeCmIC6j+G4LL399T89pRVthT5N0X3n1irptKusqaXzw+/s8WlHk613bPRpAF9wSR6VoDfN80IlfhKgnZBnM57HvhEQxLWTog41kBuGIyNhspbFS35h691A6XVMTVCXuV+fNaEj9J2ReD9YzyGgIV1nthpI0givX/fK7/JAlEQA87S3PxujnyI53KpWl0PxJBnlnNhxH3DPLKT7E0J+VPhqgzdQO72Cxq6mWhJD83QIaW1JQnFIyogq3wwskbFevq/xTCZ98cDA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4197.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(166002)(186003)(31686004)(2616005)(316002)(86362001)(6512007)(31696002)(5660300002)(6666004)(26005)(450100002)(36756003)(33964004)(83380400001)(8676002)(6506007)(66476007)(66946007)(66556008)(2906002)(6486002)(82960400001)(966005)(8936002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZSsybGZ0V1RkTzlRR3l3d0FHMkExbkEyYTVHbkJrMThlTHhCckZXRWdwMVFh?=
 =?utf-8?B?RXVJYXhDTGJQYzcwMFdSbDhnTnREOW5Gc0ZzVFJVWXpKRTNrV3lFa3BPRlVV?=
 =?utf-8?B?bGRJTGpsWGtqdzJ6djVRWFByRDlqWXlOdVBpSVU4YWZpWkltTzJXQ2NoaTlp?=
 =?utf-8?B?L2NXRHVsK3k0QlNrdzlyN3B0dzY3YzcvNTJNTEFnYnpJSWxEWU94UUlFcnBT?=
 =?utf-8?B?ZmpJb21HeU82LzMwR1h6ZDFkb2R4QjRyWUZSc3N1bFVMYks1TUVjL09wVUlR?=
 =?utf-8?B?Wm5CcENFc25XbXpGUWlOaFVneUNvdFJDS0RKZm02VHZBMWwzcjNNaXl4R0J4?=
 =?utf-8?B?eFA1VyttVmQxYmhFaXEzclJvSk9Fb250T2lVdU5MM1lxeGs1MTVvc2l0QW5I?=
 =?utf-8?B?eUswN2htYTdiemNPTFZpd0JYdHBmZjB3SEVVSW5Cdnk2OEx1M1JyRC9kalpk?=
 =?utf-8?B?N29UTGVVdk9velR1ZzZGRmZyZGc3cCt4UXV4SXJtbjJQK2JtRzMxaU5XWHYy?=
 =?utf-8?B?VTI2dVdyZEFoc2Y2WGxidm9pTGp0RGtOejFGbFN2ZmZOY3JKcmcvZnBMbytz?=
 =?utf-8?B?c3U0ZzE5dW84ckd2VmdSRFEwT05KalFkbFJaNHlXcHRhb2RKS3hJZ05OcGcv?=
 =?utf-8?B?SGIzemVXcjZGMHNlZ2RISHhya0ZTWjhzbmtWaFExN3FiaExZcFR5dHlXSUp4?=
 =?utf-8?B?aGNKSCtBQm9PSjUvaFJzRmIwNlhteHpXekFFTkkyd212azhmTDE3WW1oNXF0?=
 =?utf-8?B?NUY0MUd3cE54bnlBWWE0WFJhRS90OUdzTXgzaWVwdStMaUN3cDE0ZXY1VUVv?=
 =?utf-8?B?WFpuWitYYkZPbUVmc0pIUnNkaDlYZzE4QjVsUzFtWHZKWnZVc3RFaUVOQnRY?=
 =?utf-8?B?VUsrZVdZK3JkRzRNVU1SeHJkY0RnVFBueDN5UWpmczF0NGdsYXBJMTBrbk5a?=
 =?utf-8?B?cFhXck5JR0tMSkJhN3ZjallML3NESStvaFk3U3RHYTRobE8wSlBTUGZGdEJF?=
 =?utf-8?B?aUhXZ1NNa3UxYVFka0ZGa3RSdEJsUmhOOW5JTnBZK2owb09ESVUvaU5kYy9Z?=
 =?utf-8?B?b0lCSFRwYUVkUVk1NTdDc0xsbU0rbEpic21FZGgyLysxQjlsa3dlaWU3b3VP?=
 =?utf-8?B?ekh0aDdENGk0aDdXdmJuZU1SbTEwQ2ptY0o5Vi85NnZpSUlHR2pJREh0bHlm?=
 =?utf-8?B?TnRhc285a1JRaDJJb3dtU0w1Tk9ZS1BkdXdmTzRrSVBvaFhmSERlWVNvaUk3?=
 =?utf-8?B?b091djV3MExrYjl5MDhvS1FyVkJtZXdvUFVVVHN6MUhtcW5KVkRnVURVdXkr?=
 =?utf-8?B?cjV3RStpSEt1ZXhGNWErOUxLRDZ1aU1qaGtsb0NsSDhLby8zYkFmTHJzS21S?=
 =?utf-8?B?MWo4WE1FTTdPMkJ5R0hxNG9SZHlFRDVmUitJS1IzcmRlY0cwZHh4Q0wzWjlE?=
 =?utf-8?B?QXNmVmtEcDIzVXphQ2xveFJmSE1JTVdjSnAxNFJ1T2krZktzMTFTZXBlZS9T?=
 =?utf-8?B?dEVUUHlDc0hPQUN6ZENKRExjWGc1Ny8yZGdkYmlSaHpjcFE3WVRMNHNuTjZQ?=
 =?utf-8?B?amM5SmUxTkdJNXNZNDF5VkFWbVpVUi9pdWZONml5TktqRGNvaDJJaGZNendH?=
 =?utf-8?B?VlVLenVNalhDbkdtYnhwQ1d4M2J2V3lRRnJ5WC9CVS9ITXlXaE1Bd3VhZWZu?=
 =?utf-8?B?Uk13TDNEbGhULzhmcEVRWmlscHpCbmw0cWNqeUFTRGVROC9yL0tJRUlhbUha?=
 =?utf-8?B?ajEwSUtOa1FQOWQ3aCtQRGgyTVFaMUc2cmRSQWVCR3d3MW9qT0FlVlVWTkl2?=
 =?utf-8?B?ZHVaNFlNTUlpaW1QV1FyclRJeGZ3ZFB3d25rVzBMRnZGQ2szR1Azck5obWJU?=
 =?utf-8?B?WW0zODRncVljZkhBMmJNNGFPS3ptdXM0RUNISm5TT3JucjE1dmhtVEMwWlhy?=
 =?utf-8?B?VHhuMHpiSzFobFE2RWF6dzFOVi9lNEdPa09wQW1vQytTcWVrdWdMb3hYZWlQ?=
 =?utf-8?B?SE5yZkpBaE9HV0hzaWxCTDVzWFgxTmFOaHBLQkYwNjdPa0wybXloUDE1OGdz?=
 =?utf-8?B?Y3lERGhMMWZLUXVVKy9nb2N1NCtQK0Z6amdDcjJpSXFaQWkxWWpXVXAyWHIx?=
 =?utf-8?B?UkRPTm5XWDZTNFlDNnpaUjlmMzZlbGxwV2FWSlVHdnc4dzVnYVVkRVVpTnB5?=
 =?utf-8?B?K2NiaWhUa3czRElhSmVwZnVLRjFNTEdON2lNbWZrZ2JRdUQ0TFBsM0QvejdO?=
 =?utf-8?B?QWNXbzgvWkczblNORWROdmxBa1pOQWErTzIvSE9BZXR3YXJMN3ZFTzNuelNt?=
 =?utf-8?B?QjJPdzIwUnR6TmFiWWdFWjRCd2VIQ0xsUHlkTWJiQ1ErMzBmUnVaK0Rhd3Ro?=
 =?utf-8?Q?KxuVYqMJfn8/R4kA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1887100f-b3ea-4f25-7376-08da3cba2aeb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4197.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 12:45:50.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 8ZCvB/E9K8fmfzvX+CGesd2Bl5gk0YZMgsqSvpmIeBe9C/vzfjBcGzJsJTiNr6CT6FXeAecT1pQwQMmPml/+ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4778
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 May 2022 12:46:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8415

--------------Z0N8j5Gm0jMK0CDxi9lSZ0vy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

please be aware that the deadline for CFP is May 30.

https://events.linuxfoundation.org/open-source-summit-europe/program/cfp/ 
<https://events.linuxfoundation.org/open-source-summit-europe/program/cfp/>

Best regards,
Urs

-- 
Urs Gleim
Head of Smart Embedded Systems

Siemens AG, Technology, Otto-Hahn-Ring 6, 81739 Munich, Germany
mobile: +49 (173) 7068922, mailto:urs.gleim@siemens.com 
<mailto:urs.gleim@siemens.com>

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and 
Chief Executive Officer; Klaus Helmrich, Cedrik Neike, Matthias 
Rebellius, Ralf P. Thomas, Judith Wiese; Registered offices: Berlin and 
Munich, Germany; Commercial registries: Berlin-Charlottenburg, HRB 
12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

--------------Z0N8j5Gm0jMK0CDxi9lSZ0vy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="2"><font face="Arial">Dear all, <br>
        </font></font></p>
    <p><font size="2"><font face="Arial">please be aware that the
          deadline for CFP is May 30.</font></font></p>
    <p><a moz-do-not-send="true" href="https://events.linuxfoundation.org/open-source-summit-europe/program/cfp/"><font size="2"><font face="Arial">https://events.linuxfoundation.org/open-source-summit-europe/program/cfp/</font></font></a></p>
    <p><font size="2"><font face="Arial">Best regards,<br>
          Urs<br>
        </font></font></p>
    <div class="moz-signature">-- <br>
      
      <meta name="ProgId" content="Word.Document">
      <meta name="Generator" content="Microsoft Word 14">
      <meta name="Originator" content="Microsoft Word 14">
      <link rel="File-List" href="Urs%20ext.%20en%201_files/filelist.xml">
      <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Template>NormalEmail.dotm</o:Template>
  <o:Revision>0</o:Revision>
  <o:Pages>1</o:Pages>
  <o:Words>102</o:Words>
  <o:Characters>587</o:Characters>
  <o:Company>Licence Owner</o:Company>
  <o:Lines>4</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>688</o:CharactersWithSpaces>
  <o:Version>14.00</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
      <link rel="themeData" href="Urs%20ext.%20en%201_files/themedata.thmx">
      <link rel="colorSchemeMapping" href="Urs%20ext.%20en%201_files/colorschememapping.xml">
      <!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:DoNotShadeFormData/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
   <w:UseFELayout/>
  </w:Compatibility>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"/>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"/>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"/>
 </w:LatentStyles>
</xml><![endif]-->
      <style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Times New Roman";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1073786111 1 0 415 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:minor-fareast;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
p
	{mso-style-noshow:yes;
	mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:minor-fareast;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:11.0pt;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:minor-fareast;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;
	mso-header-margin:36.0pt;
	mso-footer-margin:36.0pt;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
-->
</style><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;}
</style>
<![endif]-->
      <div class="WordSection1">
        <span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black;mso-ansi-language:DE" lang="DE">Urs Gleim</span><span style="mso-ansi-language:DE" lang="DE"> <br>
        </span><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black;mso-ansi-language:DE" lang="DE">Head of Smart Embedded Systems<br>
        </span><span style="font-size:4.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black;mso-ansi-language:DE" lang="DE"><br>
        </span><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black;mso-themecolor:text1;mso-ansi-language:DE" lang="DE">Siemens AG, Technology, Otto-Hahn-Ring 6</span><span style="color:black;
          mso-themecolor:text1;mso-ansi-language:DE" lang="DE">, </span><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black;
          mso-themecolor:text1;mso-ansi-language:DE" lang="DE">81739
          Munich, Germany</span><span style="color:black;mso-themecolor:text1;mso-ansi-language:DE" lang="DE"> <br>
        </span><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black;mso-ansi-language:DE" lang="DE">mobile: +49 (173)
          7068922</span><span style="mso-ansi-language:DE" lang="DE">, <a href="mailto:urs.gleim@siemens.com"><span style="font-size:10.0pt;font-family:
              &quot;Arial&quot;,&quot;sans-serif&quot;">mailto:urs.gleim@siemens.com</span></a>
        </span><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black;mso-ansi-language:DE" lang="DE"><o:p></o:p></span>
        <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Siemens
            Aktiengesellschaft: Chairman of the Supervisory Board: Jim
            Hagemann Snabe; Managing Board: Roland Busch, Chairman,
            President and Chief Executive Officer; Klaus Helmrich,
            Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith
            Wiese; Registered offices: Berlin and Munich, Germany;
            Commercial registries: Berlin-Charlottenburg, HRB 12300,
            Munich, HRB 6684; WEEE-Reg.-No. DE 23691322</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
    </div>
  </body>
</html>

--------------Z0N8j5Gm0jMK0CDxi9lSZ0vy--

