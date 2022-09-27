X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.136])
 by mx.groups.io with SMTP id smtpd.web09.8036.1664262708360070247
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Sep 2022 00:11:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=f5QVcccO;
 spf=pass (domain: renesas.com, ip: 40.107.113.136, mailfrom: djunedfernando.djusdek.wz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRqcn6nkTzwDmgrqG5l0HWhTbKzJ1FzMLHR3GdEFzON2I4KhO3BTQdxeT5pLsdrzpslsuYyMYstLCHbRGCGKZO+FW6GnqSGSWDq3iysR4KL8OqcfNSzYYVORMKH73ptk7Dspm5nzoFPHTRZRggvD0Sq8L+SzODxHsPaN6Hu5fcM9aL00R6SfE8aiqwAIW2an0iqx/qSZbzCUhuK69Ic8ALwmjgWFNwm8weHkdhQhzSMryUsZvzO3OxY/EStshdSFCTayLSK0ri2mTsq73ckhwq8oGYu0NMaNQPhgeD1fnqUY+n+pEm6ps2u+OknyYIKfnXDZJacEISNvWQwN4k/+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKA2qf8h1UdqpYg/+rbyJ5pVGtcKLpKf5DVJb5b7/i4=;
 b=XdWjeEV5EAI1GdjRz8Ya7GB12rWdefCR+hfADGmoJeB6lcQasAMglxisD9/DEKY71i8HWdDXXX3Nn5eBXli9GE3ZMgJoqnpkZ3c5JvbV8K/KQY9EUZafvsxK+TLB3j27RHftRRC07gMbLWkVMLBIUjwvnUIwXBQC26tVYqTR6KROXbZK6Tc99TEtCEBMe6Y+06agXy/C+exoJrTF6E8b8PULYrfo0pzjXu2AxuSaaNxkLjaxNTqxQwQ/ukrAM/gW7/6T04SQz667364F/09W5A/23HLlbOFRPOW58gK5PqPRF8gjK0fBjxF1RtD4JiZAh2dih4quArkrpH6lZMG0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKA2qf8h1UdqpYg/+rbyJ5pVGtcKLpKf5DVJb5b7/i4=;
 b=f5QVcccOUSh0ZSFWlXsvUc6jIh0eiLApkT9+y+WGDdt8KKV/2s8gkWFjZIrOWkOHtsj0XrecNUtprKH/vsHkqsmcvDlhuRBIiKWaq+s23NG1OQPtTMX9t8+UH/LBa+MZYPwB2ifEQ6mS2a5ysdkAeb5mpYeMUAIehrGoaBeP3Hc=
Received: from TY2PR01MB4348.jpnprd01.prod.outlook.com (2603:1096:404:114::14)
 by OSZPR01MB9566.jpnprd01.prod.outlook.com (2603:1096:604:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 07:11:44 +0000
Received: from TY2PR01MB4348.jpnprd01.prod.outlook.com
 ([fe80::873e:1589:6309:467c]) by TY2PR01MB4348.jpnprd01.prod.outlook.com
 ([fe80::873e:1589:6309:467c%6]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 07:11:44 +0000
From: Djuned Djusdek <djunedfernando.djusdek.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: [Consultation][Patches] IEC-62443-4-2 CR 4.1 Information Confidentiality
Thread-Topic: [Consultation][Patches] IEC-62443-4-2 CR 4.1 Information
 Confidentiality
Thread-Index: Adi8GO0BsTCV/Al9QUe4PSQc+t2BUQ==
Date: Tue, 27 Sep 2022 07:11:43 +0000
Message-ID: 
 <TY2PR01MB4348F0C0BFE9A3ADDF49D5B2A8559@TY2PR01MB4348.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4348:EE_|OSZPR01MB9566:EE_
x-ms-office365-filtering-correlation-id: b2e8501b-3bdf-4db5-a3bc-08daa0578892
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RCduZNnFKsfQ9Dxk4QYF/AXoej6vftEQKqSeBN6nZZoUnHb227LC60wNwCrZPPUbojV7xK+ZuSC6TtqZ2GU/8xUqJgln5qrojLr8D4NC+2YC4XT1bCNnDw+bhw/K4outsissTgyfvuJ9b1hztjmgztxex0lSlVCOO0eafsEX8bxWwmM6M+KcSFRIKLV8mfC/hAsTsYUuT8v3Te+tKXMyivQoOMYeWCLeyUTvwsIMirBJlfhk33tP0+Z5GkH+1/wdHD38TGj7AGzTXG9orccwJ7l+ilFKYlTG6yS5Uc7EdG4kJQAHdX6ZRwBvo8u8siNWGNlHXgDuZo5/TV51H1t2MbiJ7tuaLk2w4LxgsrXzHZvDCCWpXcQqNRZbDpQpetaGsjnfD1SzXcLPFkPtpBH0vOEFUAk36HJKyPG7MBE14UkOPmwCC/R2OxKvwRAKOCX6BxpgxSI6go6JCXro4/MCsd6MDZj9/KaD1NZ7t4OQ7444s/sNGWhkisGw82XvEG/vbphfGrm528UA7q3Ne76T4iFeynbCWhrUmF57T2AWvB1vSx8Hzph7Dz96SlQV4y+YYPHHo4ZGu5hYwCCWIhkxpKbRfJeDaYZa81v7EYsh5nU8TiFSzAcpn2b9sak5eFB8xh2SSGqEmFxsrR4kohkZyqat1eBgZwBn6jbQQrfJHM6m7ecQyZUT3om2ID+cb2cs8ecm0SN3Dp0Jw6PlNo23qULa5Q3D5opvabr6wWZqnyWogR3eo8IpRlbpEuw0rAkTlhPBRG0tBGARMMWcEn+Mtxgker26IDeH2CsjUD4rEgOyBE5axc9d/KZ5DnmovbsWwHtFxObbBXCOWEQTudC7Zy2W2MrTZphg7KAsDFLmwi5TnBQDYj/QkPYgmKsMFSDk
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4348.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(9686003)(6506007)(26005)(122000001)(38100700002)(86362001)(71200400001)(478600001)(5660300002)(2906002)(33656002)(7696005)(166002)(38070700005)(186003)(41300700001)(64756008)(8676002)(66446008)(83380400001)(4326008)(66946007)(66476007)(6916009)(8936002)(55016003)(66556008)(52536014)(450100002)(76116006)(316002)(130860200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6COFLW+/xez7dp6x3uosDcxmF25xXlp9rHYm8VL/Hhr9y4kx5LjqWSKIdxz7?=
 =?us-ascii?Q?CDunCGi9O0oxO53GcAJ+5CpRmo8sRjQ9YRQiswea5fp/fKta+EjBkDhRbpju?=
 =?us-ascii?Q?XHgl83fTFoVflhYtV/rK/+H4lH439kYVGRF18GFP0fP8Qa8o1UvlKg1idSmt?=
 =?us-ascii?Q?nxh+bMMd1jYf7OH50AUITkxtDzzLP4Wp3gvt5jswcHNTAVFgmV5NTSEXsD90?=
 =?us-ascii?Q?8joCjtxwFcO7gPk1ImrArO2T6W6XEtdrVAfF/vXsfSCmbTaUAdwriYmF/Ee3?=
 =?us-ascii?Q?M/jj8IFXw7iLJzBojTmTuDFACQM5SxWBDWq9qb4cQM1GXE3a7/UdVpQnbhAp?=
 =?us-ascii?Q?Q69HS5iZryaZkF39gul3cyPTNHhzA5bX69sAL/hBNQJqsX5geXai6lWGBoIP?=
 =?us-ascii?Q?jdzNLBDM/RIqhB0NZLRFUeSrw+mlVBBHWNsakCn5yVrkzKHf8al/kdo0F8MD?=
 =?us-ascii?Q?4CCfnEruPDxZZecKK5U2KPuqiIxjARQ57jQrIPHMh2/2jxLy9ixB23dfBQxq?=
 =?us-ascii?Q?4sR8+o+AY5IFpiHXN0liqkJx+Zcf0jeDL8hZZPzr8yEI8tseDoTTnRXIb+4O?=
 =?us-ascii?Q?Dv392/olwQ6+QaL28SOtctMIAJHJcjCM8q1I35OYBbcg9VBGqC9bB9XQUUwF?=
 =?us-ascii?Q?Jr4GGnmlKHlwG6QxR9ZSj6QU5X2lCtHWuOSL2HXtasKyIYEhy/95I4Y5DHlN?=
 =?us-ascii?Q?UnjevYbrvQoFH2+LSaQ+A5hqcrHJR38vlHzV2xPQx3O2M+FFLkMigKLyhKmK?=
 =?us-ascii?Q?nOPymoqL/EpBFTnIO3gHFVyFnsBBVPa/IgXUtyIZSi8c649y56QoRm+yF8jZ?=
 =?us-ascii?Q?t5kYr6WbDucYOeTLIeRawb0dCqFiBLT4708jCegvb2/3UZYNM+CWZDfv+Ulj?=
 =?us-ascii?Q?gaovVtuuUgrtqKfIhN5s/GV4G592sAAE6NAI6UCWRHWd0jbAE66W4BH0yYcd?=
 =?us-ascii?Q?hPE5itm5WduGDfCNeacdciUrE5XUaSKMIuLFQOR290Hct4eRurkB0Gapvvmv?=
 =?us-ascii?Q?GndsjzbdIFk79+kXG6a/MhwHN2H+o/uRtN9VvcIqfLZkastTul5DmcUhsz5X?=
 =?us-ascii?Q?njT4e8rxmF1uPfaUaI3k08luLgvjqdF65ARo1OnAKlQjZ28c71g1eEpVhOMM?=
 =?us-ascii?Q?mg2p3yK4NQmovVY6JswtS4LUHCE9AWfpjgYxwsOpw38wO6aQo7sBzavgBExW?=
 =?us-ascii?Q?wimjzYldW7MKRLVOLn8zYp/RcJ1UWu1t2AWZYbc/UAZ6IB2rPI8srZqy0DAU?=
 =?us-ascii?Q?6ZlNkOdx3jRuIR1UuQnqBbwXWYnuHgB3sqWcjbxNbxHIvL+mT0BXJp2ykish?=
 =?us-ascii?Q?W0q57X1Upl3C1eI6oosv22Gs1/ICAL0V8L80YhCwigdAGqRLiBaSiI6FhbrI?=
 =?us-ascii?Q?L7VVyduBAC9+GjIoe7B5l4GYxk2vOs7VQUtuCx16MszuUTgGxo1bhyhaRHf4?=
 =?us-ascii?Q?AdnSj8Ae0VKID3g1WGiZVFcQdHRLZGx5IyIq4TJW2CnrEhh2spUcfrEWEMH8?=
 =?us-ascii?Q?ucLp7PBTDAUyg2YwsNamTgSW/zMh5HUd9bVEtIxRjdCTYYj6gT3PcRRlPuhC?=
 =?us-ascii?Q?K4WYLw6JwSHPNijeElBgw5agfCIqhrfh/AzzfBW9Qdjoh5b/9Xn9XgBaIyP+?=
 =?us-ascii?Q?wTxWI0BvgRKB0X8mQ/iSj1g=3D?=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4348.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e8501b-3bdf-4db5-a3bc-08daa0578892
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 07:11:44.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmUMbb9YdJI275ys1krhav48dded+Oq7KI0jUvvXEnc/k9tcK2v/j6cbvST/Hpf1hnMB5BaalusXveNwx+0FH+BQLM+O3bCazADVciQM2B/F72/hgkNSSTv1/43ipUVw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9566
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4348F0C0BFE9A3ADDF49D5B2A8559TY2PR01MB4348jpnp_"
List-Id: <cip-dev.lists.cip-project.org>

--_000_TY2PR01MB4348F0C0BFE9A3ADDF49D5B2A8559TY2PR01MB4348jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello CIP Core-WG and CIP Kernel-WG,
(CC CIP Security-WG).

Thank you for your help every time.
This is Djuned (CIP Security-WG) from Renesas,

To comply IEC-62443-4-2 CR 4.1 Information Confidentiality requirements for=
 Data-at-rest,
CIP Security-WG performed analysis and decided to employ cryptsetup package=
.

To support and verify this package, we have discussion and report here:

  *   [CIP-Security] [CR4.1] Information confidentiality (Data encryption a=
t rest) (#44) * Issues * cip-project / cip-security / iec_62443-4-x * GitLa=
b<https://gitlab.com/cip-project/cip-security/iec_62443-4-x/-/issues/44>
  *   Supporting data encryption at rest for IEC-62443-4-2 CR 4.1 (#29) * I=
ssues * cip-project / cip-core / isar-cip-core * GitLab<https://gitlab.com/=
cip-project/cip-core/isar-cip-core/-/issues/29>

Besides, we prepared series of patches:
<isar-cip-core>

  *   cip-core-image-security.bb: Add cryptsetup and fdisk packages (ec9f98=
5f) * Commits * cip-project / cip-core / isar-cip-core * GitLab<https://git=
lab.com/cip-project/cip-core/isar-cip-core/-/commit/ec9f985fd1cc26b6ee6d2e4=
b9952c4fbff91cc1f>
  *   start-qemu: Create and add secure-image.img as /dev/vdb for cip-core-=
image-security (d6eaf0d2) * Commits * cip-project / cip-core / isar-cip-cor=
e * GitLab<https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/d=
6eaf0d216d10d1a873998961b3a88688027fb35>
  *   doc: Add README for IEC-62443-4-2 CR 4.1 Information Confidentiality =
(2de2aaa5) * Commits * cip-project / cip-core / isar-cip-core * GitLab<http=
s://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/2de2aaa5331b2094=
137779c4375ff877394415c9>
<cip-kernel-config>

  *   5.10.y-cip/arm64: qemu_arm64_defconfig: Enable Crypto modules (40c4ba=
f1) * Commits * cip-project / cip-kernel / cip-kernel-config * GitLab<https=
://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/40c4baf1211=
cc3018fede298bd5def6dcf51ddee>

Now, we ask for your help to check/review our patches before we create Pull=
-Requests.
Thank you,

with Best Regards,

Djuned Fernando DJUSDEK (Mr.)
djunedfernando.djusdek.wz@renesas.com<mailto:djunedfernando.djusdek.wz@rene=
sas.com>
Software Business Development Department
Enterprise Infrastructure Business Division
IoT and Infrastructure Business Unit
Renesas Electronics Corporation


--_000_TY2PR01MB4348F0C0BFE9A3ADDF49D5B2A8559TY2PR01MB4348jpnp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Yu Gothic";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0mm;
	margin-right:0mm;
	margin-bottom:0mm;
	margin-left:42.0pt;
	mso-para-margin-top:0mm;
	mso-para-margin-right:0mm;
	mso-para-margin-bottom:0mm;
	mso-para-margin-left:4.0gd;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Yu Gothic";}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Yu Gothic";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:99.25pt 30.0mm 30.0mm 30.0mm;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:286933195;
	mso-list-type:hybrid;
	mso-list-template-ids:-1772302032 491451120 67698699 67698701 67698689 676=
98699 67698701 67698689 67698699 67698701;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;
	font-family:"Yu Gothic";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B2;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F06C;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B2;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:126.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F06C;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B2;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:189.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:815798963;
	mso-list-template-ids:-209712776;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2
	{mso-list-id:1163859771;
	mso-list-template-ids:-712862434;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3
	{mso-list-id:1370953652;
	mso-list-template-ids:934807366;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0mm;}
ul
	{margin-bottom:0mm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
<v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
</o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"JA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hell=
o CIP Core-WG and CIP Kernel-WG,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">(CC =
CIP Security-WG).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Than=
k you for your help every time.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">This=
 is Djuned (CIP Security-WG) from Renesas,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">To c=
omply IEC-62443-4-2 CR 4.1 Information Confidentiality requirements for Dat=
a-at-rest,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">CIP =
Security-WG performed analysis and decided to employ cryptsetup package.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">To s=
upport and verify this package, we have discussion and report here:<o:p></o=
:p></span></p>
<ul style=3D"margin-top:0mm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:-18.0pt;mso-para-margin=
-left:0gd;mso-list:l0 level1 lfo3">
<span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-security=
/iec_62443-4-x/-/issues/44">[CIP-Security] [CR4.1] Information confidential=
ity (Data encryption at rest) (#44)
<span lang=3D"EN-US"><span lang=3D"EN-US">&middot; Issues </span></span><sp=
an lang=3D"EN-US"><span lang=3D"EN-US">&middot; cip-project / cip-security =
/ iec_62443-4-x
</span></span><span lang=3D"EN-US"><span lang=3D"EN-US">&middot; GitLab</sp=
an></span></a></span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p><=
/o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:-18.0p=
t;mso-para-margin-left:0gd;mso-list:l0 level1 lfo3">
<span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-core/isa=
r-cip-core/-/issues/29">Supporting data encryption at rest for IEC-62443-4-=
2 CR 4.1 (#29)
<span lang=3D"EN-US"><span lang=3D"EN-US">&middot; Issues </span></span><sp=
an lang=3D"EN-US"><span lang=3D"EN-US">&middot; cip-project / cip-core / is=
ar-cip-core
</span></span><span lang=3D"EN-US"><span lang=3D"EN-US">&middot; GitLab</sp=
an></span></a></span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p><=
/o:p></span></li></ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Besi=
des, we prepared series of patches:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&lt;=
isar-cip-core&gt;<o:p></o:p></span></p>
<ul style=3D"margin-top:0mm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:-18.0pt;mso-para-margin=
-left:0gd;mso-list:l0 level1 lfo3">
<span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-core/isa=
r-cip-core/-/commit/ec9f985fd1cc26b6ee6d2e4b9952c4fbff91cc1f">cip-core-imag=
e-security.bb: Add cryptsetup and fdisk packages (ec9f985f)
<span lang=3D"EN-US"><span lang=3D"EN-US">&middot; Commits </span></span><s=
pan lang=3D"EN-US"><span lang=3D"EN-US">&middot; cip-project / cip-core / i=
sar-cip-core
</span></span><span lang=3D"EN-US"><span lang=3D"EN-US">&middot; GitLab</sp=
an></span></a></span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p><=
/o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:-18.0p=
t;mso-para-margin-left:0gd;mso-list:l0 level1 lfo3">
<span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-core/isa=
r-cip-core/-/commit/d6eaf0d216d10d1a873998961b3a88688027fb35">start-qemu: C=
reate and add secure-image.img as /dev/vdb for cip-core-image-security (d6e=
af0d2)
<span lang=3D"EN-US"><span lang=3D"EN-US">&middot; Commits </span></span><s=
pan lang=3D"EN-US"><span lang=3D"EN-US">&middot; cip-project / cip-core / i=
sar-cip-core
</span></span><span lang=3D"EN-US"><span lang=3D"EN-US">&middot; GitLab</sp=
an></span></a></span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p><=
/o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:-18.0p=
t;mso-para-margin-left:0gd;mso-list:l0 level1 lfo3">
<span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-core/isa=
r-cip-core/-/commit/2de2aaa5331b2094137779c4375ff877394415c9">doc: Add READ=
ME for IEC-62443-4-2 CR 4.1 Information Confidentiality (2de2aaa5)
<span lang=3D"EN-US"><span lang=3D"EN-US">&middot; Commits </span></span><s=
pan lang=3D"EN-US"><span lang=3D"EN-US">&middot; cip-project / cip-core / i=
sar-cip-core
</span></span><span lang=3D"EN-US"><span lang=3D"EN-US">&middot; GitLab</sp=
an></span></a></span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p><=
/o:p></span></li></ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&lt;=
cip-kernel-config&gt;<o:p></o:p></span></p>
<ul style=3D"margin-top:0mm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:-18.0pt;mso-para-margin=
-left:0gd;mso-list:l0 level1 lfo3">
<span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-kernel/c=
ip-kernel-config/-/commit/40c4baf1211cc3018fede298bd5def6dcf51ddee">5.10.y-=
cip/arm64: qemu_arm64_defconfig: Enable Crypto modules (40c4baf1)
<span lang=3D"EN-US"><span lang=3D"EN-US">&middot; Commits </span></span><s=
pan lang=3D"EN-US"><span lang=3D"EN-US">&middot; cip-project / cip-kernel /=
 cip-kernel-config
</span></span><span lang=3D"EN-US"><span lang=3D"EN-US">&middot; GitLab</sp=
an></span></a></span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p><=
/o:p></span></li></ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Now,=
 we ask for your help to check/review our patches before we create Pull-Req=
uests.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Than=
k you,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">with Best Regards,</span><span =
lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:9.0pt;color:=
#7F7F7F"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:9.0pt;col=
or:#404040">Djuned Fernando DJUSDEK (Mr.)<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"mailto:djunedfernand=
o.djusdek.wz@renesas.com"><span style=3D"font-size:9.0pt;color:#2F5496">dju=
nedfernando.djusdek.wz@renesas.com</span></a></span><span lang=3D"EN-US" st=
yle=3D"font-size:9.0pt;color:#2F5496"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:9.0pt;color:=
#404040">Software Business Development Department<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:9.0pt;color:=
#404040">Enterprise Infrastructure Business Division<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:9.0pt;color:=
#404040">IoT and Infrastructure Business Unit<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:9.0pt;col=
or:#404040">Renesas Electronics Corporation<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_TY2PR01MB4348F0C0BFE9A3ADDF49D5B2A8559TY2PR01MB4348jpnp_--

