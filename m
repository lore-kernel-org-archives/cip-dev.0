Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C35CC4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 05:42:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.8712.1714455733792506090
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 22:42:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 43U5gAQf1604538; Tue, 30 Apr 2024 14:42:11 +0900
X-Iguazu-Qid: 2rWhNMNec5F4B1MPfp
X-Iguazu-QSIG: v=2; s=0; t=1714455730; q=2rWhNMNec5F4B1MPfp; m=d5YEr/rmQWyOuVCsT3N7jpVi7etyaA+Br/8pGiEbza0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 43U5g7V41354222
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 30 Apr 2024 14:42:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOZC2Zj+TtpOOPYNkP9a0NJRgvLii02UJTTts4T3RYKn54FEdcq5cyhWNwnj6M7332UNTPqpJi7hGD9JMKk0CpGB+e+KWyyid9ClE7F5SiIWNd5LH1ELP7Kt0v79SebWLiBGSKHBGKb9wtmtY82CK9tgGNV/yJvp2xxpbZv+niec6MGDb/YH/j1miVF190suiDkroKOBBxl7TJ+81cP3ITKfjABuD1GOYX+7BKkYfgV3I9LvxKjrzxeUD74SXJxHox7ycSb8neZOTJsO+QjXvP2IueSfJyrUWHDuvezj+w4tbpXLv6qPusYjdg30exusH8rqOinXZh93NwnTPTmidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l7q+wfn5jLDpZnXlt7iBT8XWwoisAq677trDljcoho=;
 b=b17RcHMqgqM9M2wrv83z07O9wqLr8QGgyQkt0W3Ff89+5AjSArdZmD7MxvS05ztoJ2NqVCSCfDKQIvUVxOjvtHk5br+LAGLWu2mII1OpVZ/lwxIN+xjdOVvQ2H5dKsQMY2GJoszyPvRO9F5FLL3OeIp6+hYBFj/E7fZslnMftpL6jTVoDoxAZQYIhqwTGjeUsZYvRK4eqsuhCXp165JtjH1pRuyjVm8fNnPgwYZIKRJJe8esaUeBZxGPMbJIEIDcX4/yZD6A8ZYhF/P9ROjBKOMfgWGDg17TGsqWaIeBzMZQkaywngmLie+/m0iJRyfFG+zbBeTkUw3jWNpsiD0UoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <cip-dev@lists.cip-project.org>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: Updates about cip-core-ci repository
Thread-Topic: Updates about cip-core-ci repository
Thread-Index: Adqav3IefljCpDvdTAeZaFSlAVlLnA==
Date: Tue, 30 Apr 2024 05:42:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103C363AE0853268133CBDBC21A2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB8414:EE_
x-ms-office365-filtering-correlation-id: 63097f29-cd27-498b-667e-08dc68d844f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QVZxZmRubWdUVVU3VHZhdUl1YkhaZjdCU3E1SXFTNGxwVFlVQURCRzVl?=
 =?iso-2022-jp?B?QUh4V25NaTJzeEUrdGNpc0FZbHJSUDVVWjZzeFhJMnVnWllySGtXVjND?=
 =?iso-2022-jp?B?QW16aVJIRVJaVEx6TDVVbVFjTGFxazRSLys5WFJVM3o4aDhhZEM3S3g1?=
 =?iso-2022-jp?B?SHEvYTl4V1Ywc1doMVlkYXlNNzd1UUlTcWRkVGZNZWZoMnFUNC93aEVh?=
 =?iso-2022-jp?B?T0VjUitOcFFla0k0a0huQW1yQXNWTTE4SitqclhSWTl4L050OWJJYUE4?=
 =?iso-2022-jp?B?ZWhxazU3Q1JqZUM5ekxkcFZGT2VBZXpybXRWL1N3TTg3ZGNyNDNCS3ZY?=
 =?iso-2022-jp?B?SERkOGR4dnB4L205REYzLy8rSUtxa2RHZU1VT0NkM200UUtKRmZvZkpK?=
 =?iso-2022-jp?B?RDFXNTRrQTl2U0dUTzdWSHFvZ2ozQ2xoaHpSRnJDZEJUTlNxMGIxbTN6?=
 =?iso-2022-jp?B?VzMxMlRjYzdZdWN4UGN2dmtKOFMwazFCNzl0TGpJUTlpT01uNkdBa0NH?=
 =?iso-2022-jp?B?MjlJZTFZRVpKcjJXTEtpeGNNZm9kUzJ2NVpjc0kzdXNNTEY5aFdMMDBC?=
 =?iso-2022-jp?B?L3NhS3FsSnp6Y1ArRjJqWmFkNHJ5WVk2d3dXc2gwYUE1V3BYK2JKOWdn?=
 =?iso-2022-jp?B?MHVQUjlER0VLWkwwSEEvdEZXZTVLVDRBQmJCOFhkQ3l4OHVjWE5SWk4v?=
 =?iso-2022-jp?B?TnM5TjNCSUVHczZ3aUppREdoeXUxZlRYb2JlTlJWMVl4UDBOOUhZaWlU?=
 =?iso-2022-jp?B?WGFPNjdJZVluV21STkZvTGdoTUlXNDhnamJSc28rL1ozSHhxSVFLTUlN?=
 =?iso-2022-jp?B?WWFBaTZ6eXpWZTNFUnhoM051UWtvWHJPY0xPRVhWZ2xTLzgrRXdIVlZY?=
 =?iso-2022-jp?B?NE15SXdsdWFQbytIaGlHY3RheStlSGowVXBxM2tjbVVFM1NhKzBPSEha?=
 =?iso-2022-jp?B?cmorOVJQTDJYeEYzVGN0MXF4RGNldlpQTDdjOWhtNWtGeW5hNlgvTENG?=
 =?iso-2022-jp?B?aGZQREtDS3FTUE1YM29wbjFFQzRVV0JtdWNWa2dXYWVDSDVCcE1rdEYy?=
 =?iso-2022-jp?B?RWJ6d3ZzQlhUcUFPRlNnNUozdGN2VHNHcjBzZXFHZ3R0N1ozQjFKUTNQ?=
 =?iso-2022-jp?B?WGFyS1hmd0htaElmNm1YK29CKzVUOVBGeDVVa0lJbnVrNjV5V2dWMGd5?=
 =?iso-2022-jp?B?bndwU2dtNTE0TzBDUndZcEJoakJVMW5jTENRSHpWeWxybGFhQXhTTVVX?=
 =?iso-2022-jp?B?T2RuMEZTckQrSnhCUXZCZ0JBNDlYVW1YRk9ucGwrOGNBMWV1RytrYWRL?=
 =?iso-2022-jp?B?VEswU1BSUUxLSDdQK252UkRodDhMdUd3OGttNkxuWU9BSzJHdWVuKzgz?=
 =?iso-2022-jp?B?WTVqRnU2bGJ4SmprOURhODc5eTl0VDFmMk9PcUo3UXk5bVNOaDlkeFp0?=
 =?iso-2022-jp?B?R0VTSkNpMnlmV3d4NTc3U29OWHdTcmpFVGF6ejd1dllWekQyTmxPNmRZ?=
 =?iso-2022-jp?B?MkQ1NEtiR3pzQWRrQ3lFcmZabVYrZTdrTElFbGwwbjZ6VytsbVBuTVVJ?=
 =?iso-2022-jp?B?Q0RTQmtMZ1V0OWsrdWhmbzYwaDhpYmZTSDVlL3lDRXAwOUF0WHlDSHNs?=
 =?iso-2022-jp?B?ekVFdkdManc5UVpkalQ0anNaWUlqcEhhcllXYTRTNnJLRkd6eUJnVjNS?=
 =?iso-2022-jp?B?SWlSRXRRMXFJWjZlOHpyUGdBbE5ydDBVMFBOWlhINXB5RGxnMnVvS2xy?=
 =?iso-2022-jp?B?SUpoQWtpSGl1YzZ3dHNxbkZtS1Nma2E3MkFORjdMRkw5OEVpbVBVVEQ3?=
 =?iso-2022-jp?B?d05Gem5NODg2cVRPbjFjSkZodGVZRGUzWHA5YnNGUFd5OWZsbkdJSEJj?=
 =?iso-2022-jp?B?eER3Sm51YU44SXVnc3Nab3VMKzB6SkpmSUhkME9JVUNTbDJrejZiKzlC?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RVZDQ2RvQmxBRUQ0VGlJWVhzNTEwUWRNa0tXRVIzcXhMbHVQSzd5VS9J?=
 =?iso-2022-jp?B?WjkvSjFHdi9RZ091ZnZjVFpObmM3V1lWNFZ0eTdrRS9QTTcrNGRyVEEx?=
 =?iso-2022-jp?B?aXBDV2xUTlBoNS9DS3BwcVlWQS9OUjRkNExkSlJRVUhpL29EUDJ3b3Qx?=
 =?iso-2022-jp?B?SVNIN1paL1NML0prM0h6WnRGUlhCT3RnRzZwSk10MmlocVh1V29PL3Rl?=
 =?iso-2022-jp?B?QVFMT3hiRTBqT0swQWRkeVh5cG9yRlRrcmg1cC9aZGNHSGtlNVJiVjVX?=
 =?iso-2022-jp?B?SHVuSHM3U2lLeDFzcVd4dU1sNVBRMmJhbHBuRlRpSW1hK0Q3RWJnVGdo?=
 =?iso-2022-jp?B?NExWRld2cnF6Y3RlT2pVeW02VzZmVkJxU090bVpWcnBsNThNeTJIV2Nu?=
 =?iso-2022-jp?B?SzYwclFXcklUU29DVUgwanNtenU3UkVxcDl1Z3NGMmNEazkyaHFZUnk2?=
 =?iso-2022-jp?B?b1FXTzdkZmt6bVdUZm1KZjl1TU5yL0hMbHlQU2ZBbEM4dXl3LytxK2Q4?=
 =?iso-2022-jp?B?aHJlekNKanhNVzEwTUdYNytmMzY0ZFJjdU5PREFnVFlsTW9XMDBTR21L?=
 =?iso-2022-jp?B?bzlBTHlWS3g5S29FcWJ0YWVFMUEyVVczL0pQaEJxRGVpNk9hcmh5MXJr?=
 =?iso-2022-jp?B?VFBNaStMVTZ6UDRMR1lqQlYzNytOUmVoSmlMUjBNY3dIa1RvVm5zOGVJ?=
 =?iso-2022-jp?B?RGd0d1FYdFAzc01GaytObkdCYmpwazYwTW00WFVCd3I2Q1pnRnNXeVpE?=
 =?iso-2022-jp?B?dUxSZ2kxbHBLanBGNGJRamlvR3FEcE1rc1ZHTis0Nk9HOURFajdZMTM2?=
 =?iso-2022-jp?B?VUpmZ0pzQkRZcFliL210TmtKQTlFNnRiOXM1Wmc0bVRQUmxQdGV5U1lV?=
 =?iso-2022-jp?B?MGpJYTZKVTFKU0dLWDJLWHJNQldQVkZBMC9SNkZZdEFIVUttSWdzSDYr?=
 =?iso-2022-jp?B?ZHI2dDl2dmRRNzdPaTdzRndrczBrMXBqSkhLWkhLdklLWjVyQXlsME1T?=
 =?iso-2022-jp?B?R3BBSEI0OUNrWmEydnJqaWtDWk1VcThuR1NHT3hDREVSQVdHdTBiZG1X?=
 =?iso-2022-jp?B?NWFyNGd0VmhhdVljRHZ6MkRsVXMwQVVEV2NNQzRZNy9xNmk0QjlYZnNN?=
 =?iso-2022-jp?B?WWZFcEdGWmU1MEV2d1Awcytlck4rTHIyRUNKT2JLZW1jREpNOTA0cU0w?=
 =?iso-2022-jp?B?a2ZOa1ZTclZBOXc1b3dSaUdSWlNLcXNLMUN5bU12cTFpRW1GT0dMRmsv?=
 =?iso-2022-jp?B?TDQ1RWtEdDVGYTZORGtJdS9IOUZ3T2Q1dGVYUGlZeWVPSDlRaFNSeU5r?=
 =?iso-2022-jp?B?M3crT1BvU0E3ZCtFOWUyY25BUnJGckM2Y1VaM05DRXh1dGN6OVI1NEg4?=
 =?iso-2022-jp?B?aElOYzVYWU9ZUVlMUHhLREd1aTNXNjFyUUdyT3RseG03YkNiZWpjVW9k?=
 =?iso-2022-jp?B?STc1OFhCai84b1hvbzNYYXVMRUhlenZDbWcxcUJKZGo1RHFBVUY0UXFu?=
 =?iso-2022-jp?B?SHF2YXpRV1FZVXdFcEx2ci9lTnoxOWVPRWdCa2dNejV6cWl6UUl4dk1p?=
 =?iso-2022-jp?B?aHdyUEx2d2xRSDFudmJyMVNhTk5SL3hXbUpxM01nTjFjRTd2WG1WVkgy?=
 =?iso-2022-jp?B?dFNjVFVRakJra29aMDcyNEg0bHl1UUZ5UUVvWTBpMHhPU0tsL0M0S3c4?=
 =?iso-2022-jp?B?Wm1SSW9tWTJ0U0pxbFQ0K0p6YjV2ejY5UVNIMlFMMmhteDRsYWFYZ1kw?=
 =?iso-2022-jp?B?L0NxMnNtVnd0TWI5RU50MHF1VVhSWWRWaHFIRFV1RU9XcGVnRGJEU2R2?=
 =?iso-2022-jp?B?c1ZCckYrWW5CQnFLcURKd0NrbDJ2RE5TN24zR3NZM0lnZDR6Ky94WWdq?=
 =?iso-2022-jp?B?SU1EU2lQYkFRTzBaeVJEM3JOdHVvd3BEN1YrRzB4a1V5VDA3cEZJNkVG?=
 =?iso-2022-jp?B?b1c0anZNQm9oazJxMFFkeWMyQURFN2pJUFZXTHZmUkcrTkNTTzRJMUQ1?=
 =?iso-2022-jp?B?RzRodDlrQmVlNE1XNUtyMGtPQklucWxvMUpEZFpsaHA5WmFwS3RWZTV6?=
 =?iso-2022-jp?B?bWdmYUlmVnlzMmdMZkJhM1lOeWxuSndjZUtlSEpoZi9qNFI5OTVLL2Jp?=
 =?iso-2022-jp?B?RGQxVE55WVBuSDZabEoxcE5rUCtxMGtaL1pDWTNhek9CMkoyNWRmSEJv?=
 =?iso-2022-jp?B?NmpOY05pTEliZHNnTE0wVmNvMTNpMXo2ZE1wMHlmUW1qOFNOVWRwVXlM?=
 =?iso-2022-jp?B?ZEVYdk9DbXdvd1FRa1dpTkY2TnRWNTNHT2lFMTVIZjd2U3ZPbWVja3FE?=
 =?iso-2022-jp?B?R0JSQjZnVE9jVXlXS00yZ3paUzBKSldVK3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103C363AE0853268133CBDBC21A2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63097f29-cd27-498b-667e-08dc68d844f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 05:42:05.8806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btmJc9z4dBx9Pqisp7JtkFRuqknKg8wLxjGaeR6YfzDL+tRbusP77UsE5Qduu98qGHRSb5knmlvlScdFAPqF2N3RhvtiaIhn43Nqoa13hZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8414
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Apr 2024 05:42:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15784

--_000_OS3PR01MB6103C363AE0853268133CBDBC21A2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Thank you for reviewing the below mentioned merge requests.


  1.  https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/1
  2.  https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/2

Both the MRs are merged to master. I created a weekly pipeline schedule on =
master branch which shall create and submit jobs to CIP LAVA server.  Pleas=
e refer the status of latest pipeline --> https://gitlab.com/cip-playground=
/cip-core-ci/-/pipelines/1272807912 .

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)


--_000_OS3PR01MB6103C363AE0853268133CBDBC21A2OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1708682441;
	mso-list-type:hybrid;
	mso-list-template-ids:-324658112 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for reviewing the below mentioned merge re=
quests.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requ=
ests/1">https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/1</a=
><o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;ms=
o-list:l0 level1 lfo1"><a href=3D"https://gitlab.com/cip-playground/cip-cor=
e-ci/-/merge_requests/2">https://gitlab.com/cip-playground/cip-core-ci/-/me=
rge_requests/2</a><o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Both the MRs are merged to master. I created a weekl=
y pipeline schedule on master branch which shall create and submit jobs to =
CIP LAVA server.&nbsp; Please refer the status of latest pipeline
<span style=3D"font-family:Wingdings">&agrave;</span> <a href=3D"https://gi=
tlab.com/cip-playground/cip-core-ci/-/pipelines/1272807912">
https://gitlab.com/cip-playground/cip-core-ci/-/pipelines/1272807912</a> .<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103C363AE0853268133CBDBC21A2OS3PR01MB6103jpnp_--


