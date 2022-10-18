Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837E5C43217
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 12:07:40 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.137])
 by mx.groups.io with SMTP id smtpd.web11.5823.1666094853727408192
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Oct 2022 05:07:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=MEAiuI+R;
 spf=pass (domain: renesas.com, ip: 40.107.114.137, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj2wukBOTs5JKjmiXaGxIPhnRbCPOLfKAcdVWflaQPpojqKL7WE2e3FrxhaeAQt3bNr6ZHMDfuH2o7AxXQ+wO95cvTy2dcZsFoWhBaH8mjQ38x2VE+eeaYMFXUzGjkU1ge8bcrtnRrls5HZO4lssKJVttdyChQ8jdYUa7DBlbRb/txZ+awUnRSbnAOhYFPvjoWSpFu4jn8YIOtkf8dreBKAs2B485VaDNme/QfeabJ2vk5crF8tyIiOsnMct8k8Oocse8zIZ2RNUX2apghJF7j9TxAXzBrYqxnnVoGMhE3Kb6w9vYT0uUUUS5481YDc4kDzLERNUMnzndFNBaEvwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tq8jlUcg8orJ1BeoVqNhKyTaRSlbBFNxMmfzEBSoTs=;
 b=WaHJlOARDhpDQ12fkjjpQAPqJmwxvFUOEl2nHjgQLSWZxFfTSXnFqUaMrIGFfg1kBUfbGwD6oLPyWUnjrHV7uEAfXlMhyzusoc/EZgrn7N3rx/O74kPDI5uHO8Wd26U5pmwMQEbDXtovRqj5BdgMF2JpRwd/FPNpGBQPQV6raFerPmLTjqoMKyfWIjFIfBiJwWeu9SqY6p2ijDdkL+XdSVVZ74a49YfTgxMDiALolDPRLtgcee7o7UnAouDPJjYiHQAuQVIaMmmm5YcYVrv4y5mwtCnddXQ2+ij/HgMYh25ulI97Kv37lQqmQyo1Pfc3eMQOmoDu0j/pfEQOdGAcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tq8jlUcg8orJ1BeoVqNhKyTaRSlbBFNxMmfzEBSoTs=;
 b=MEAiuI+ROtqNz5CELbFRvnC04db7nWP5IwkDRBKKIi4NwY70aOCNhb5elalghect4NWZPkGMZbk/8djDv278xqp+4JMzMHFHMY06RuIHhn47FTdRWAYh9r6/Tt2kxQNFfNk97bu/WH6mrPQ3wB9c5Z7O3f1NleXOGoTpvaAqNxI=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYCPR01MB9307.jpnprd01.prod.outlook.com (2603:1096:400:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 12:07:32 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 12:07:32 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Tests run on CIP-LAVA platform
Thread-Topic: Tests run on CIP-LAVA platform
Thread-Index: Adjh9pXyvPJeWbcCTVG87YJuWZoCXgA8xCnA
Date: Tue, 18 Oct 2022 12:07:32 +0000
Message-ID: 
 <TYCPR01MB1058805F4393A618DCDB79741B7289@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <47d0ac6c735c4251abb3602a43b20d77@mentor.com>
In-Reply-To: <47d0ac6c735c4251abb3602a43b20d77@mentor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYCPR01MB9307:EE_
x-ms-office365-filtering-correlation-id: 8fba3f03-61f2-4775-b75a-08dab101560c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 W9ATTlHw0XZZUA/+M/fxkgb4IKUsgVTwNGiR+iKFVrqndsztrPqIObzSdJRp/eZBYqE36Gb5PPJMATRguA6VmoNw2ksafjjY20amGgx/j6rW4okLX5dEOOp5nLlmv7LCvrGX5peDVOQfBc3zv0G+R03XFkKckUJLXutMQeRyfNs51YeuW28BWrpevfQ/uhvRG7HrwNeJ+mwlQ/Ng3s5eQaHaJBvQvgnLaomNpnOOKjCW9uNB+FT7ElR1Y8Ptm/gEReSpoh4KDzd+c23x/Z0sZreSeHieUZxhJ+xb50kyAeZT002/NDd94CWKWfuzosqy6f5D9IKpxUmYQSyjB/0rQ7DvQvyEdRUS9/0FGDiV1+rNA/xIo8Nf2mKFgCGz/OabGFkGVWECaZ4jGBkqF+KoHDoihZy9fmEJVarELPBIDM/HUTmX73omp5Y8k0ABjKThv+abPr5kHvHpvEdapyQwbTBq6z26ZmvoBdaOOG4WDcJhzVH4OOsTiUt7mTY8P9zBfwA/6MIb+IShDGGoEWWUco8/gf2QwDHZGLPvAb6avQOhDvho8T0U7Lq0i+11v6WoAZ7NqBNaF6bwAIRYFLLrxUNi7fRMfUzUDyqxG6aMDb5sfVsCC/VZrs4nvOCZmipV+gQUWETaPp1KDcUots0l2xLiHl8SymTaPvXLpQ61o2Mt3O4cF/MeRA4+4fktjL2GtqtwULvzlop0pL7IUm10uYFtRDqa6NCud1Ya2FuRzk/XBUULpY/Ytq2Xy6E8o7T84cLt7iqM/7+8qGGo674ZfpW3N033JoL/a8lwhj/Eyjs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(38070700005)(122000001)(478600001)(71200400001)(966005)(166002)(38100700002)(33656002)(316002)(186003)(66556008)(66476007)(64756008)(8676002)(66946007)(6916009)(66446008)(76116006)(6506007)(53546011)(26005)(7696005)(41300700001)(9326002)(52536014)(8936002)(9686003)(55016003)(86362001)(5660300002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?OxqcNSeKPScBQMKosr6NbOs6UF69sB8uaqYhM3eo7KpLZQrL/gqNXkPs?=
 =?Windows-1252?Q?/2Gmn/yWLGpe7FDKPHVDi79VxpP57TJ4FVER6Cd1GDAa1/CgPmrMvY4w?=
 =?Windows-1252?Q?6yqDw5TKIhYDShOrkYG3QRQROfA13z8sI6CeaEQpUfAc54V2vcaDc+ao?=
 =?Windows-1252?Q?6QUaHnP6jO85DClVyaJbR5vZBALk1JXlDFdUCVeiZqQjB9v8OjDEscFn?=
 =?Windows-1252?Q?riiZBHZZ8cju/81aNwJY4RRvwccnCZVuvmxI+16XOwtioYamQ2IUOuxB?=
 =?Windows-1252?Q?SO4z6XUEl1gam0KMUav1KBFXso1wcRAYwfUIGUU+sepUi34AdZKRPffo?=
 =?Windows-1252?Q?QoCGxrqNyV+QP4WWKWPbXe8vbgATjP9lL86eAHN8pjnFjy0vXaxs+qMY?=
 =?Windows-1252?Q?BZ8aPZkhW5GSE6zb4kTcwFzyExIMFz+CG2xAnzYFwKE+zPQaE5OlJHJ8?=
 =?Windows-1252?Q?wKZBEUK8irzLwNkg+jce0sNFoOwjAiTpaM2UU6qWzAlXM095e3hcGw6B?=
 =?Windows-1252?Q?HAbXW0id3o6vLeqFiJ18/cth2n9SgGb/HNyerdTgQc3zHJSYiHyG+clM?=
 =?Windows-1252?Q?4Z74mafSwkHPRZ1ooElUxLx4Y8G9DFInODujGKNnw3jvbPZO4NJIxdG4?=
 =?Windows-1252?Q?qR2WjrWsH4Tk1V0590R9xUeaYoOFwKV8QtdMYYfy3kc1AYMAo+P5v+Pl?=
 =?Windows-1252?Q?y7BxfYU8kvgwlYej/rzqmop1iPPW+xYar0BGOXYqF6QTal8XwVJJilU3?=
 =?Windows-1252?Q?bXsHS3oiIJOeNSTnFWbuuvWG6UpnslnAub0Dp0nAmYe2BG1LCC3xmg9b?=
 =?Windows-1252?Q?aQdDzEn8uY0kkBYfxgtkDLhuy+gzeCsfMauK9G92B52peHUmKXCOwMAU?=
 =?Windows-1252?Q?Y0FXIwB+LeowjanSRCW8kB6vmkIeg9gnrQil7E92Cz0EwSVIbYBYgEGc?=
 =?Windows-1252?Q?7TvgZO7z4QFi3sR57OzGI7rJmsiATZS7oePO9Ttpmng6ZHP/1MC98EU/?=
 =?Windows-1252?Q?WRpsCuNIfSqHggdvSgiAZqyxLUmLOaWKrm4b3+fVLUB6MFxj2ylZ/fsU?=
 =?Windows-1252?Q?dgE5g+XTk0YUPuZkBM4myLZBlJLhf6j8sHl9K7sFtlQnKw/f1ekY8yKl?=
 =?Windows-1252?Q?Le7nulnFb8v1kLyMffOn/v21hEVnpj8kg34R3ew2qBC01yB9hfeemgL2?=
 =?Windows-1252?Q?19cMPXvW9HLbuPBPWLATSOQFXksGh8dwNv+COMvhQ5u3TJYgQnLvD7bO?=
 =?Windows-1252?Q?kjfwqDjMSQvmr6i2fv92/HZ194R0RpwgomDbUN09aHbwcIkx1ENVyTH9?=
 =?Windows-1252?Q?fv8uUVP8edYsuO0p5KnSUMqEqRPpYfSus3wCOwSaBrW7qPWhPo0hCBya?=
 =?Windows-1252?Q?5CaXG5PNWnmKFAfbqb46qp6q6ntoGi8HDVnOPTgBjmTAAjKGPt6ZstYB?=
 =?Windows-1252?Q?L8IXhoXDSTBLDVCFnfxSGuIilg6VprI61jLJe/A6w2bfH4gsxNigMB9/?=
 =?Windows-1252?Q?XqC7ufm6B8Fw0/+kxlWNRLAit5YP2qYr5xq+q5Ka5Uy0n817bAo6ltIz?=
 =?Windows-1252?Q?fO3FRiX5onuFUbxx+BmLHNL698J+owsHW3aYet3/o9TJ0KJeYeGtpm6e?=
 =?Windows-1252?Q?PHy4g8OSqgCrHhymemTvrMcMtoVNf3UugicOxWdlovvTpdvaHJf0vNs1?=
 =?Windows-1252?Q?u/nZuWI5sZNKcBK+0WmFb257AOWgO4JGxPK3vEl2Of+zEKfyz381BQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB1058805F4393A618DCDB79741B7289TYCPR01MB10588jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fba3f03-61f2-4775-b75a-08dab101560c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 12:07:32.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgNRqf28LLhjEXPlwK1ZUuZyQJBlQEwFBrMcQB3AJJz1cYUwl5aBH1be8HTbrVzoRtC8HtBle+29CK/GHmOnrfShvXGNb5RYPfcfgsIYYLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9307
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Oct 2022 12:07:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9772

--_000_TYCPR01MB1058805F4393A618DCDB79741B7289TYCPR01MB10588jp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Sarath,

Some of those test jobs you linked to are very old.

Looking at more recent jobs the smc issue you reported is no longer there.

However the RT tests are having issues completing the test due to =93/usr/b=
in/env: 'python': No such file or directory=94.
The tests seem to get run, but the final step is a python script that parse=
s the results.
We=92ll have to get that fixed.

Kind regards, Chris

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of P T, Sarath via lists.cip-project.org
Sent: 17 October 2022 08:04
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Tests run on CIP-LAVA platform

Hi Team,

I could able to see there are few tests are running in the CIP LAVA platfor=
m. I am showing the list below what all LAVA tests are running in the CIP L=
AVA platform.


Test-case
CIP LAVA job link
Status
Comments

i)                     spectre-meltdown-checker-test
https://lava.ciplatform.org/scheduler/job/686074<https://jpn01.safelinks.pr=
otection.outlook.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fscheduler%2=
Fjob%2F686074&data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C73512d153912=
48f0e28f08dab00dc6a7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638015870=
466469681%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT=
iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Ds6LI32yl%2BAq2kMacyP1plIr=
7bu9DFfaCHGw5ez6E9tY%3D&reserved=3D0>
Not run
Reason of failure

./spectre-meltdown-checker.sh: Permission denied.

ii)                   hackbench
https://lava.ciplatform.org/results/634343<https://jpn01.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fresults%2F634343&=
data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C73512d15391248f0e28f08dab0=
0dc6a7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638015870466469681%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D4ajRpqUrsZX0CSIbsFRUWpNJ6cyRoAHXGM2NDzh=
WlII%3D&reserved=3D0>
PASS


iii)                 cyclictest
https://lava.ciplatform.org/results/634097<https://jpn01.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fresults%2F634097&=
data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C73512d15391248f0e28f08dab0=
0dc6a7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638015870466469681%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dm0f%2FygYtt4U4%2Fm7qJ1wHviYPItQxh46wrjX=
d7iWJSXY%3D&reserved=3D0>
SKIP
Reason of failure

$ ./cyclictest.sh -D 2m -p 98 -i 1000 -t 1 -a 0 -h '' -w '' this command is=
 giving =93/usr/bin/cyclictest: unrecognized option=94 error

iv)                 cyclicdeadline
https://lava.ciplatform.org/results/633692<https://jpn01.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fresults%2F633692&=
data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C73512d15391248f0e28f08dab0=
0dc6a7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638015870466625902%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DQ3ixEoBSW8Ld28zwN2bqCjMPqd1UzIPELHdnbTD=
72Yk%3D&reserved=3D0>
Not run
Reason of failure


while executing cyclicdeadline.sh getting an error like

/usr/bin/cyclicdeadline: invalid option -- 'q'


Is there any specific reason why few test-cases are running through LAVA ?


Regards

Sarath P T


--_000_TYCPR01MB1058805F4393A618DCDB79741B7289TYCPR01MB10588jp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:-apple-system;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:2048095819;
	mso-list-type:hybrid;
	mso-list-template-ids:-1634539996 1474486544 1074331673 1074331675 1074331=
663 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l0:level1
	{mso-level-number-format:roman-lower;
	mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:54.0pt;
	text-indent:-36.0pt;
	mso-ansi-font-size:10.5pt;
	font-family:-apple-system;
	color:#172B4D;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#7030A0">Hello Sarath,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0">Some of those test job=
s you linked to are very old.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0">Looking at more recent=
 jobs the smc issue you reported is no longer there.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0">However the RT tests a=
re having issues completing the test due to =93/usr/bin/env: 'python': No s=
uch file or directory=94.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0">The tests seem to get =
run, but the final step is a python script that parses the results.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0">We=92ll have to get th=
at fixed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0"><o:p>&nbsp;</o:p></spa=
n></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-fareast-languag=
e:EN-GB">From:</span></b><span lang=3D"EN-US" style=3D"mso-fareast-language=
:EN-GB"> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt=
;
<b>On Behalf Of </b>P T, Sarath via lists.cip-project.org<br>
<b>Sent:</b> 17 October 2022 08:04<br>
<b>To:</b> cip-dev@lists.cip-project.org<br>
<b>Subject:</b> [cip-dev] Tests run on CIP-LAVA platform<o:p></o:p></span><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Hi Team,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">I could able to see there are f=
ew tests are running in the CIP LAVA platform. I am showing the list below =
what all LAVA tests are running in the CIP LAVA platform.<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" style=3D"border-collapse:collapse">
<tbody>
<tr>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:#F4F5F7">Test-=
case</span></strong><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:#F4F5F7">CIP L=
AVA job link</span></strong><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border:solid window=
text 1.0pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:#F4F5F7">Statu=
s</span></strong><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border:solid window=
text 1.0pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:#F4F5F7">Comme=
nts</span></strong><o:p></o:p></p>
</td>
</tr>
<tr>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:54.0pt;text-indent:-36.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span style=3D"font-size:10.5pt;font-family:-apple-sys=
tem;color:#172B4D"><span style=3D"mso-list:Ignore">i)<span style=3D"font:7.=
0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
</span></span></span><![endif]><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">spectre=
-meltdown-checker-test</span><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border-top:none;bo=
rder-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wind=
owtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><a href=3D"https://jpn01.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fscheduler%2Fjob%2F686074&a=
mp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C73512d15391248f0e28f08d=
ab00dc6a7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638015870466469681%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Ds6LI32yl%2BAq2kMacyP1plIr7bu9DFf=
aCHGw5ez6E9tY%3D&amp;reserved=3D0">https://lava.ciplatform.org/scheduler/jo=
b/686074</a><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal">Not run<o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#C00000;letter-spacing:-.05pt;background:white;font-wei=
ght:normal">Reason of failure
<o:p></o:p></span></strong></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.5pt;font-family:-appl=
e-system;color:#172B4D;letter-spacing:-.05pt;background:white"><br>
<strong><span style=3D"font-family:-apple-system">./spectre-meltdown-checke=
r.sh</span></strong></span></b><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">: Permi=
ssion denied.</span><o:p></o:p></p>
</td>
</tr>
<tr>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:54.0pt;text-indent:-36.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span style=3D"font-size:10.5pt;font-family:-apple-sys=
tem;color:#172B4D"><span style=3D"mso-list:Ignore">ii)<span style=3D"font:7=
.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">hackben=
ch</span><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border-top:none;bo=
rder-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wind=
owtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><a href=3D"https://jpn01.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fresults%2F634343&amp;data=
=3D05%7C01%7Cchris.paterson2%40renesas.com%7C73512d15391248f0e28f08dab00dc6=
a7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638015870466469681%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D4ajRpqUrsZX0CSIbsFRUWpNJ6cyRoAHXGM2NDzh=
WlII%3D&amp;reserved=3D0">https://lava.ciplatform.org/results/634343</a><o:=
p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal">PASS<o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</td>
</tr>
<tr>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:54.0pt;text-indent:-36.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span style=3D"font-size:10.5pt;font-family:-apple-sys=
tem;color:#172B4D"><span style=3D"mso-list:Ignore">iii)<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">cyclict=
est</span><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border-top:none;bo=
rder-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wind=
owtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><a href=3D"https://jpn01.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fresults%2F634097&amp;data=
=3D05%7C01%7Cchris.paterson2%40renesas.com%7C73512d15391248f0e28f08dab00dc6=
a7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638015870466469681%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dm0f%2FygYtt4U4%2Fm7qJ1wHviYPItQxh46wrjX=
d7iWJSXY%3D&amp;reserved=3D0">https://lava.ciplatform.org/results/634097</a=
><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal">SKIP<o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#C00000;letter-spacing:-.05pt;background:white;font-wei=
ght:normal">Reason of failure
<o:p></o:p></span></strong></p>
<p class=3D"MsoNormal"><span style=3D"color:#172B4D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:-apple-s=
ystem;color:#172B4D;letter-spacing:-.05pt;background:white">$<strong><span =
style=3D"font-family:-apple-system"> ./cyclictest.sh -D 2m -p 98 -i 1000 -t=
 1 -a 0 -h '' -w ''</span></strong> this
 command is giving <strong><span style=3D"font-family:-apple-system">=93/us=
r/bin/cyclictest: unrecognized option=94
</span></strong>error</span><o:p></o:p></p>
</td>
</tr>
<tr>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoListParagraph" align=3D"right" style=3D"margin-left:54.0pt;t=
ext-align:right;text-indent:-36.0pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span style=3D"font-size:10.5pt;font-family:-apple-sys=
tem;color:#172B4D"><span style=3D"mso-list:Ignore">iv)<span style=3D"font:7=
.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">cyclicd=
eadline</span><o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.85pt;border-top:none;bo=
rder-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wind=
owtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><a href=3D"https://jpn01.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Flava.ciplatform.org%2Fresults%2F633692&amp;data=
=3D05%7C01%7Cchris.paterson2%40renesas.com%7C73512d15391248f0e28f08dab00dc6=
a7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638015870466625902%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DQ3ixEoBSW8Ld28zwN2bqCjMPqd1UzIPELHdnbTD=
72Yk%3D&amp;reserved=3D0">https://lava.ciplatform.org/results/633692</a><o:=
p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal">Not run<o:p></o:p></p>
</td>
<td width=3D"156" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#C00000;letter-spacing:-.05pt;background:white;font-wei=
ght:normal">Reason of failure
<o:p></o:p></span></strong></p>
<p style=3D"margin:0cm;background:white"><span style=3D"font-size:10.5pt;fo=
nt-family:-apple-system;color:#172B4D;letter-spacing:-.05pt"><br>
<br>
while executing <strong><span style=3D"font-family:-apple-system">cyclicdea=
dline.sh</span></strong> getting an error like</span><span style=3D"color:#=
172B4D"><o:p></o:p></span></p>
<p style=3D"background:white;margin:0.75rem 0px 0px;box-sizing: border-box;=
font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;white-s=
pace:pre-wrap;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thic=
kness: initial;text-decoration-style: initial;text-decoration-color: initia=
l;word-spacing:0px">
<strong><span style=3D"font-size:10.5pt;font-family:-apple-system;color:#17=
2B4D;letter-spacing:-.05pt">/usr/bin/cyclicdeadline: invalid option -- 'q'<=
/span></strong><span style=3D"font-size:10.5pt;font-family:-apple-system;co=
lor:#172B4D;letter-spacing:-.05pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-IN">=
Is there any specific reason why few test-cases are running through LAVA ?
<br>
<br>
<br>
Regards <br>
<br>
Sarath P T <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYCPR01MB1058805F4393A618DCDB79741B7289TYCPR01MB10588jp_--

