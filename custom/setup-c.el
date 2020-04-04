;; company-c-headers
(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers);; auto-completion for C/C++ headers
  )
(add-to-list 'company-c-headers-path-system "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/")

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style "linux" ;; set style to "linux"
      c-basic-offset 4); indentation width

(use-package cc-mode
  :init
  (define-key c-mode-map  [(tab)] 'company-complete)
  (define-key c++-mode-map  [(tab)] 'company-complete))


(unless (package-installed-p 'cmake-mode); syntax highlighting for CMakeLists.txt and .cmake files.
  (package-refresh-contents)
  (package-install 'cmake-mode))
(setq package-list '(cmake-mode))
(require 'cmake-mode)

(unless (package-installed-p 'highlight-doxygen)
  (package-refresh-contents)
  (package-install 'highlight-doxygen))
(use-package highlight-doxygen
  :config
  (highlight-doxygen-global-mode 1));; enable the minor `highlight-doxygen-mode` mode for
                                    ;; all major modes specified in highlight-doxygen-modes (c,c++,objc)

(provide 'setup-c)
