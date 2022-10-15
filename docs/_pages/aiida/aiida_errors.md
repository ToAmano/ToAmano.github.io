# エラーログ， トラブルシューティング


## QE

- aiida.common.exceptions.InputValidationError: You cannot specify explicitly the 'outdir' flag in the 'CONTROL' namelist or card.

    QEのinputでは，いくつかのタグがAiiDAによって自動的に決定される（outdirなど）ので，これらのタグを自分で決定しようとするとsubmission errorになる．



## postgreSQL

- libpq.5.dylib not found
  postgreSQLをアップデートした時に出てきたエラー．アップデートしたことでlibpq.5.dylibの場所が変わり，aiidaがそれを見つけられなかった．.zshenvにパスを設定してやることで解決．
  
  ```bash
  export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/Cellar/postgresql/14.5_1/lib/postgresql@14:$DYLD_FALLBACK_LIBRARY_PATH
  ```

