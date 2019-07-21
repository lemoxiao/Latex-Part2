Format 49

Provides amsmath    1
Provides amssymb    1
Provides amstext    1
Provides array      1
Provides listings   1
Provides enumitem   1
Provides hyperref   1
Provides makeidx    1
Provides multirow   1
Provides subfig     1
Provides units      1
Provides wasysym    1
Provides xcolor     1

Style Front_Matter
        Category        Structure
        LatexType       Command
        LatexName       frontmatter
        KeepEmpty       1
        Margin          First_Dynamic
        NextNoIndent    1
        ParSkip         0
        TopSep          2.5
        BottomSep       0.5
        ParSep          0
        Align           Center
        LabelType       Static
        LabelBottomSep  0
        LeftMargin      M
        LabelString     "--- Front Matter ---"

        Font
          Family        Sans
          Series        Bold
          Size          Largest
          Color         Blue
        EndFont
End

Style Main_Matter
        CopyStyle       Front_Matter
        Category        Structure
        LatexName       mainmatter
        LabelString     "--- Main Matter ---"
End

Style Back_Matter
        CopyStyle       Front_Matter
        Category        Structure
        LatexName       backmatter
        LabelString     "--- Back Matter ---"
End

Style Doc_Attr
        Margin          Dynamic
        LatexType       Command
        LatexName       docattr
        Category        FrontMatter
        InTitle         1
        NextNoIndent    1
        Align           Left
        LabelType       Static
        LabelString     "Doc Attr:"
        LabelSep        M
        LabelFont
          Size          Small
        EndFont
        TextFont
          Size          Small
          Color         blue
        EndFont
End

Style Revisions
        Margin                Static
        LatexType             Environment
        LatexName             revisions
        LatexParam            [customHdr]
        Category              FrontMatter
        NextNoIndent          1
        LeftMargin            MMM
        RightMargin           MMM
        ParIndent             MM
        ItemSep               0
        TopSep                0.7
        BottomSep             0.7
        ParSep                0.7
        Align                 Center
        LabelType             Above
        LabelString           "Revision History"
        LabelBottomSep        3.5
        Font
          Size                Small
        EndFont
        LabelFont
          Series              Bold
          Size                Large
        EndFont
End

Style SubTitle
        Margin                Static
        LatexType             Command
        Category              FrontMatter
        InTitle               1
        LatexName             subtitle
        ParSkip               0.4
        ItemSep               0
        TopSep                0
        BottomSep             1
        ParSep                0.8
        Align                 Center
        LabelType             No_Label
        Font
          Size                Large
        EndFont
        HTMLTag               h1
        HTMLTitle             true
End

Float
        Type                  listing
        GuiName               Listing
        Placement             tbp
        Extension             lol
        NumberWithin          none
        Style                 plain
        ListName              "List of Listings"
        IsPredefined          true
        UsesFloatPkg          false
        ListCommand           lstlistoflistings
        RefPrefix             lst
End

Style Paragraph_Item
        Category              List
        Margin                Static
        LatexType             Item_Environment
        LatexName             paraitem
        NextNoIndent          1
        LeftMargin            MMN
        LabelSep              xx
        ItemSep               0.0
        TopSep                0.7
        BottomSep             0.7
        ParSep                0.0
        Align                 Block
        AlignPossible         Block, Left
        LabelType             Itemize
        HTMLTag               ul
        HTMLItem              li
        HTMLLabel             NONE
End

InsetLayout Flex:Filename
        LyXType         charstyle
        LatexType       Command
        LatexName       filename
        LabelString     "filename"
        Font
          Family        Typewriter
        EndFont
        LabelFont
          Family        Roman
        EndFont
End

InsetLayout Flex:Command
        CopyStyle       Flex:Filename
        LatexName       command
        LabelString     "command"
End

InsetLayout Flex:Parameter
        CopyStyle       Flex:Filename
        LatexName       parameter
        LabelString     "parameter"
End

InsetLayout Flex:UserInput
        CopyStyle       Flex:Filename
        LatexName       userinput
        LabelString     "userinput"
End

InsetLayout Flex:GuiMenu
        LyXType         charstyle
        LatexType       Command
        LatexName       guimenu
        LabelString     "guimenu"
        Font
          Family        Typewriter
        EndFont
        LabelFont
          Family        Roman
        EndFont
End
