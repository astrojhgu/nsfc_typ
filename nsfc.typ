#let nsfc_content(doc)={
  let en_sans_serif = "Georgia"
  let en_serif = "Times New Roman"
  let zh_hei = ("FZHei-B01", "FZHei-B03")
  let zh_kai = ("AR PL UKai",)
  let zh_shusong = ("FZShuSong-Z01", "FZShuSong-Z01S")
  let title_font = (en_serif, ..zh_kai)
  let body-font = (en_serif, ..zh_shusong)
  let heading-font = (en_serif, ..zh_kai)

  let clean_numbering(..schemes) = {
    (..nums) => {
      let (section, ..subsections) = nums.pos()
      let (section_scheme, ..subschemes) = schemes.pos()

      if subsections.len() == 0 {
        numbering(section_scheme, section)
      } else if subschemes.len() == 0 {
        numbering(section_scheme, ..nums.pos())
      } else {
        clean_numbering(..subschemes)(..subsections)
      }
    }
  }

  set heading(numbering: clean_numbering("（一）", "1.", "(a)"))

  show heading.where(
  level: 1
): it => block(width: 100%)[
  #set text(16pt, font: heading-font, weight: "regular", fill:blue)
  #h(2em)
  #counter(heading).display(it.numbering)
  #it.body
]

show heading.where(
  level: 2
): it => block(width: 100%)[
  #set text(16pt, font: heading-font, weight: "regular",fill:blue)
  #h(2em)
  #counter(heading).display(it.numbering)
  #it.body
]

  set text(size: 15pt)
  align(center)[
    #block(text(font: title_font, weight: "bold", 18pt, [*报告正文*]))
    #v(0.5em)
  ]
  [~~~~~~~~参照以下提纲撰写，要求内容翔实、清晰，层次分明，标题突出。#text(blue)[请勿删除或改动下述提纲标题及括号中的文字。]
  ]
  set par(first-line-indent: 2em,justify: true, linebreaks: "optimized")


  
  show figure.where(kind: image): it => block(width: 100%)[#align(center)[
    #set figure(placement: auto)
      #it.body
      // #it.supplement // original
      #it.caption
    ]]

  show figure.where(kind: table): it => block(width:100%)[
    #it.caption
    //#set figure.caption(position: top)
    #it.body
  ]
  

  set math.equation(numbering: "(1)")

  set text(font: body-font, lang: "zh", region: "cn")
  set terms(indent: 1em, hanging-indent: 0em)

  
  doc
}
